# == Schema Information
#
# Table name: versions
#
#  id           :integer          not null, primary key
#  library_id   :integer          not null
#  number       :string           not null
#  file_url     :string           not null
#  weight       :integer
#  check_weight :boolean          default(FALSE), not null
#  active       :boolean          default(FALSE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'scale'

class Version < ActiveRecord::Base
  belongs_to :library, inverse_of: :versions, touch: true

  validates :library, presence: true
  validates :number,  presence: true
  validates :file_url, presence: true

  validates :number, format: { with: /\A(\d+\.)*\d+\z/ }
  
  validates :file_url, format: { with: URI.regexp, message: "must be valid URL" }
  validates :file_url, format: { with: /\.js\z/, message: "must be JS file" }

  scope :latest, -> { active.sort_by{ |v| v.sortable_number }.reverse.first }

  include Activeable
  include Weightable

  before_validation :weigh, if: :check_weight?
  after_save :update_library_weight, if: :is_latest?

  # Sets weight (file size in bytes) of version
  def weigh
    scale = Scale.new
    scale.add(file_url)
    self.weight = scale.weigh
  end

  # Updates weight of library to weight of version
  def update_library_weight
    self.library.update_attributes(weight: weight)
  end

  # Returns true if latest version of library
  def is_latest?
    return false unless active?
    id == self.class.where(library: library).latest.id
  end

  # Returns number in a sortble format by padding it with zeros
  # e.g. number = '12.3.456' -> '000120000300456'
  def sortable_number
    number.split('.').map { |n| n.rjust(5, '0') }.join
  end
end
