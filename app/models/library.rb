# == Schema Information
#
# Table name: libraries
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  slug         :string           not null
#  source_url   :string           not null
#  homepage_url :string
#  description  :string
#  popularity   :integer
#  category_id  :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'github_checker'

class Library < ActiveRecord::Base
  belongs_to :category
  has_many   :versions, inverse_of: :library

  accepts_nested_attributes_for :versions, limit: 100

  scope :by_weight,     -> { all.sort_by { |lib| lib.versions.latest.weight } }
  scope :by_popularity, -> { order(popularity: :desc) }
  scope :by_name,       -> { order(:name) }

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

  include Sluggable

  def relevant_json
    to_json(only: [
      :id,
      :source_url,
      :homepage_url,
      :popularity,
      :category_id
    ], methods: [
      :info,
      :weight,
      :weight_pretty
    ])
  end

  def info
    info = "#{name}"
    info << " &mdash; #{description}" if description.present?
    info
  end

  def weight
    versions.latest.weight
  end

  def weight_pretty
    versions.latest.weight_pretty
  end

  before_save :check_github

  def check_github
    github_checker   = GithubChecker.new(source_url)
    self.description = github_checker.check_description
    self.popularity  = github_checker.check_stars
  end
end
