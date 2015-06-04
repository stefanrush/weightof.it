# == Schema Information
#
# Table name: libraries
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  slug              :string           not null
#  weight            :integer
#  source_url        :string           not null
#  homepage_url      :string
#  description       :string
#  popularity        :integer
#  category_id       :integer          not null
#  check_description :boolean          default(FALSE), not null
#  check_popularity  :boolean          default(FALSE), not null
#  active            :boolean          default(FALSE), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'github_checker'

class Library < ActiveRecord::Base
  belongs_to :category
  has_many   :versions, inverse_of: :library

  accepts_nested_attributes_for :versions, limit: 100

  scope :active,        -> { where(active: true) }
  scope :by_popularity, -> { order(popularity: :desc) }

  validates :name,       presence: true
  validates :source_url, presence: true
  validates :category,   presence: true
  
  validates :source_url, format: {
    with: URI.regexp,
    message: "must be valid URL"
  }
  validates :homepage_url, format: {
    with: URI.regexp,
    message: "must be valid URL"
  }, allow_blank: true

  validates :popularity, numericality: {
    greater_than_or_equal_to: 0
  }, allow_blank: true

  include Pageable
  include Sluggable
  include Weightable
  
  def app_json
    to_json(only: [
      :id,
      :name,
      :weight,
      :description,
      :source_url,
      :homepage_url,
      :popularity,
      :category_id
    ], methods: [
      :weight_pretty
    ]).to_s.html_safe
  end

  before_validation :check_github, if: :check_any?

  def check_github
    github_checker   = GithubChecker.new(source_url)
    self.description = github_checker.check_description if check_description
    self.popularity  = github_checker.check_stars       if check_popularity
  end

  def check_any?
    check_description || check_popularity
  end
end
