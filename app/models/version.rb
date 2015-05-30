# == Schema Information
#
# Table name: versions
#
#  id         :integer          not null, primary key
#  library_id :integer          not null
#  number     :string           not null
#  raw_url    :string           not null
#  weight     :integer
#  active     :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Version < ActiveRecord::Base
  belongs_to :library, inverse_of: :versions, touch: true

  scope :active, -> { where(active: true) }
  scope :latest, -> { active.order(number: :desc).first }

  validates :library, presence: true
  validates :number,  presence: true
  validates :raw_url, presence: true
  
  validates :raw_url, format: { with: URI.regexp, message: "must be valid URL" }
  validates :raw_url, format: { with: /.+\.jsx?\z/, message: "must be JS file" }

  include Weighable
end
