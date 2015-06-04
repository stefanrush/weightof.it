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

  scope :active,      -> { where(active: true) }
  scope :by_position, -> { active.order(:position, :name) }

  validates :name,     presence: true
  validates :position, presence: true

  include Sluggable

  def app_json
    to_json(only: [
      :id,
      :name,
      :slug
    ]).to_s.html_safe
  end
end
