# == Schema Information
#
# Table name: versions
#
#  id           :integer          not null, primary key
#  library_id   :integer          not null
#  number       :string           not null
#  raw_url      :string           not null
#  weight       :integer
#  check_weight :boolean          default(FALSE), not null
#  active       :boolean          default(FALSE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Version < ActiveRecord::Base
  belongs_to :library, inverse_of: :versions, touch: true

  scope :active, -> { where(active: true) }
  scope :latest, -> { active.order(number: :desc).first }

  validates :library, presence: true
  validates :number,  presence: true
  validates :raw_url, presence: true
  
  validates :raw_url, format: { with: URI.regexp, message: "must be valid URL" }
  validates :raw_url, format: { with: /\.js\z/, message: "must be JS file" }

  include Weighable
  include Weightable

  after_save :update_library_weight, if: :is_latest?

  def update_library_weight
    library.update_attributes(weight: weight)
  end

  def is_latest?
    self.class.where(library: library).latest.id == id
  end
end
