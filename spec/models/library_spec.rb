# == Schema Information
#
# Table name: libraries
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  slug         :string           not null
#  source_url   :string           not null
#  homepage_url :string
#  stars        :integer          default(0), not null
#  category_id  :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

RSpec.describe Library, type: :model do
  describe "respond to" do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:slug) }
    it { is_expected.to respond_to(:homepage_url) }
    it { is_expected.to respond_to(:source_url) }
    it { is_expected.to respond_to(:stars) }
    it { is_expected.to respond_to(:versions) }
    it { is_expected.to respond_to(:category) }
  end

  describe "relationship" do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:versions) }
  end

  describe "validation" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_presence_of(:source_url) }
    it { is_expected.to validate_presence_of(:stars) }
    it { is_expected.to validate_presence_of(:category) }

    it { is_expected.to_not allow_value('invalid-url!').for(:source_url) }
    it { is_expected.to_not allow_value('invalid-url!').for(:homepage_url) }
    it { is_expected.to allow_value('http://valid-url.com').for(:source_url) }
    it { is_expected.to allow_value('http://valid-url.com').for(:homepage_url) }
  end

  it_behaves_like 'Sluggable'
end
