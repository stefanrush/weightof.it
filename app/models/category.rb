# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  slug       :string           not null
#  position   :integer          default(0), not null
#  active     :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base
  has_many :libraries

  validates :name,     presence: true
  validates :position, presence: true

  scope :app_data,    -> { select(self.app_fields).active.by_position }
  scope :by_position, -> { order(:position, :name) }

  include Activeable
  include Sluggable

  # Returns array of category fields used in JSON data
  def self.json_fields
    [
      :id,
      :name,
      :slug
    ]
  end

  # Returns array of library fields used in app data
  def self.app_fields
    self.json_fields.concat [:created_at, :updated_at]
  end

  # Returns category JSON data used in app
  def app_json
    to_json(only: self.class.json_fields).to_s.html_safe
  end
end
