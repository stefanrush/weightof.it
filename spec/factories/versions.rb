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

FactoryGirl.define do
  factory :version do
    library
    sequence(:number)  { |n| "#{n}.0" }
    sequence(:raw_url) { |n| "https://raw.com/l#{n}.js" }
    weight             { rand(10000) }
    active             true

    trait :real do
      number       '1.11.3'
      raw_url      'https://code.jquery.com/jquery-1.11.3.js'
      weight       nil
      check_weight true
    end
  end
end
