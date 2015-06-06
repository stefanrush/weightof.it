# == Schema Information
#
# Table name: libraries
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  slug              :string           not null
#  weight            :integer
#  source_url        :string           not null
#  homepage_url      :string
#  description       :string
#  popularity        :integer
#  category_id       :integer          not null
#  check_description :boolean          default(FALSE), not null
#  check_popularity  :boolean          default(FALSE), not null
#  approved          :boolean          default(FALSE), not null
#  active            :boolean          default(FALSE), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

FactoryGirl.define do
  factory :library do
    sequence(:name)         { |n| "L#{n}" }
    sequence(:slug)         { |n| "l-#{n}" }
    weight                  { rand(10000) }
    sequence(:homepage_url) { |n| "https://l#{n}.com" }
    sequence(:source_url)   { |n| "https://github.com/l#{n}" }
    sequence(:description)  { |n| "L#{n} description" } 
    popularity              { rand(10000) } 
    active                  true
    approved                true
    category

    trait :real do
      name              "jQuery"
      slug              nil
      weight            nil
      homepage_url      "https://jquery.com/"
      source_url        "https://github.com/jquery/jquery"
      description       nil
      popularity        nil
      check_description true
      check_popularity  true
    end
  end
end
