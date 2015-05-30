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

FactoryGirl.define do
  factory :version do
    library
    sequence(:number)  { |n| "#{n}.0" }
    sequence(:raw_url) { |n| "https://raw.com/l#{n}.js" }
    weight             { rand(10000) }

    trait :real do
      number  '1.11.3'
      raw_url 'https://code.jquery.com/jquery-1.11.3.js'
      weight  nil
    end
  end
end
