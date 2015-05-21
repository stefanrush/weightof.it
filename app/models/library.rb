# == Schema Information
#
# Table name: libraries
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  slug         :string           not null
#  homepage_url :string           not null
#  source_url   :string           not null
#  category_id  :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Library < ActiveRecord::Base
  belongs_to :category
  has_many   :versions

  validates :name,         presence: true
  validates :homepage_url, presence: true, format: { with: URI.regexp }
  validates :source_url,   presence: true, format: { with: URI.regexp }
  validates :category,     presence: true

  include Sluggable
end
