# == Schema Information
#
# Table name: versions
#
#  id         :integer          not null, primary key
#  library_id :integer          not null
#  number     :string           not null
#  raw_url    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :version do
    library
    sequence(:number)  { |n| "#{n}.0" }
    sequence(:raw_url) { |n| "https://raw.com/l#{n}.js" }
  end
end
