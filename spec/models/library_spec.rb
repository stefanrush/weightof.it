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

require 'spec_helper'

RSpec.describe Library, type: :model do
  describe "respond to" do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:homepage_url) }
    it { is_expected.to respond_to(:source_url) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:popularity) }
    it { is_expected.to respond_to(:versions) }
    it { is_expected.to respond_to(:category) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:versions) }
    it { is_expected.to accept_nested_attributes_for(:versions) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:source_url) }
    it { is_expected.to validate_presence_of(:category) }

    it { is_expected.to_not allow_value('invalid-url!').for(:source_url) }
    it { is_expected.to_not allow_value('invalid-url!').for(:homepage_url) }
    it { is_expected.to allow_value('http://valid-url.com').for(:source_url) }
    it { is_expected.to allow_value('http://valid-url.com').for(:homepage_url) }

    it { is_expected.to validate_numericality_of(:popularity).is_greater_than_or_equal_to(0) }
  end

  it_behaves_like 'Sluggable'

  def new_model
    build_stubbed(:library, :real)
  end

  let(:model) { new_model }

  describe "#check_github" do
    it "parses description and star (popularity) data from GitHub API" do
      model.check_github
      expect(model.description).to_not be_nil
      expect(model.popularity).to_not be_nil
    end
  end
end
