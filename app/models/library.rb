# == Schema Information
#
# Table name: libraries
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  slug         :string           not null
#  source_url   :string           not null
#  homepage_url :string
#  stars        :integer          default(0), not null
#  category_id  :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Library < ActiveRecord::Base
  belongs_to :category
  has_many   :versions

  validates :name,         presence: true
  validates :source_url,   presence: true, format: { with: URI.regexp }
  validates :stars,        presence: true
  validates :category,     presence: true
  validates :homepage_url, format: { with: URI.regexp }, allow_blank: true

  include Sluggable
end
