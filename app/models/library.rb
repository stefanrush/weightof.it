# == Schema Information
#
# Table name: libraries
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  slug         :string           not null
#  source_url   :string           not null
#  homepage_url :string
#  popularity   :integer          default(0), not null
#  category_id  :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Library < ActiveRecord::Base
  belongs_to :category
  has_many   :versions, inverse_of: :library

  accepts_nested_attributes_for :versions, limit: 50

  validates :name,       presence: true
  validates :source_url, presence: true
  validates :popularity, presence: true
  validates :category,   presence: true
  
  validates :source_url, format: {
    with: URI.regexp,
    message: "must be valid URL"
  }
  validates :homepage_url, format: {
    with: URI.regexp,
    message: "must be valid URL"
  }, allow_blank: true

  include Sluggable
end
