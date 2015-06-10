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

  scope :app_data,    -> { select(self.app_fields).active.by_position }
  scope :active,      -> { where(active: true) }
  scope :by_position, -> { order(:position, :name) }

  validates :name,     presence: true
  validates :position, presence: true

  include Sluggable

  def self.app_fields
    [
      :id,
      :name,
      :slug
    ]
  end

  def app_json
    to_json(only: self.class.app_fields).to_s.html_safe
  end
end
