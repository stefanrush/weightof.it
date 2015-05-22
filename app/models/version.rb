# == Schema Information
#
# Table name: versions
#
#  id         :integer          not null, primary key
#  library_id :integer          not null
#  number     :string           not null
#  raw_url    :string           not null
#  weight     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Version < ActiveRecord::Base
  belongs_to :library

  validates :library, presence: true
  validates :number,  presence: true
  validates :raw_url, presence: true, format: { with: URI.regexp }
  validates :weight,  numericality: { greater_than: 0 }, allow_blank: true
end
