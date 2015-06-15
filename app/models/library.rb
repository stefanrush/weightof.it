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
#  approved          :boolean          default(FALSE), not null
#  active            :boolean          default(FALSE), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'github_checker'

class Library < ActiveRecord::Base
  belongs_to :category
  has_many   :versions, inverse_of: :library

  accepts_nested_attributes_for :versions, limit: 10

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

  scope :app_data,      -> { select(self.app_fields).approved.active.weighed }
  scope :approved,      -> { where(approved: true) }
  scope :unapproved,    -> { where(approved: false) }
  scope :by_popularity, -> { order(popularity: :desc) }
  scope :by_name,       -> { order(:name) }

  include Activeable
  include Pageable
  include Sluggable
  include Weightable

  before_validation :check_github, if: :check_any?

  # Returns array of library fields used in app
  def self.app_fields
    [
      :id,
      :name,
      :weight,
      :description,
      :source_url,
      :homepage_url,
      :popularity,
      :category_id
    ]
  end
  
  # Returns library JSON data used in app
  def app_json
    to_json(only: self.class.app_fields,
            methods: [:weight_pretty]).to_s.html_safe
  end

  # Sets description and popularity fields based on data from GitHub 
  def check_github
    github_checker   = GithubChecker.new(source_url)
    self.description = github_checker.check_description if check_description?
    self.popularity  = github_checker.check_stars       if check_popularity?
  end

  # Returns true if GitHub should be checked
  def check_any?
    check_description? || check_popularity?
  end

  # Updates boolean fields to true for library and its versions
  def approve
    self.update_attributes(check_description: true,
                           check_popularity: true,
                           active: true,
                           approved: true)
    versions.each do |version|
      version.update_attributes(check_weight: true, active: true)
    end
  end 
end
