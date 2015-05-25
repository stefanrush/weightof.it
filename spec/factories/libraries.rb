# == Schema Information
#
# Table name: libraries
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  slug         :string           not null
#  source_url   :string           not null
#  homepage_url :string
#  description  :string
#  popularity   :integer
#  category_id  :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :library do
    sequence(:name)         { |n| "L#{n}" }
    sequence(:slug)         { |n| "l-#{n}" }
    sequence(:homepage_url) { |n| "https://l#{n}.com" }
    sequence(:source_url)   { |n| "https://github.com/l#{n}" }
    category

    trait :real do
      name "jQuery"
      slug nil
      homepage_url "https://jquery.com/"
      source_url "https://github.com/jquery/jquery"
      popularity nil
    end
  end
end
