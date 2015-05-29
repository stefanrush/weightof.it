# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  slug       :string           not null
#  position   :integer          default(0), not null
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

  def relevant_json
    to_json(only: [
      :id,
      :name,
      :slug
    ])
  end
end
