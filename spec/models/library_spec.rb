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
#  weight_gzipped    :integer
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
    it { is_expected.to respond_to(:check_description) }
    it { is_expected.to respond_to(:check_popularity) }
    it { is_expected.to respond_to(:approved) }
    it { is_expected.to respond_to(:active) }
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
  
  it_behaves_like "Pageable"
  it_behaves_like "Sluggable"
  it_behaves_like "Weightable"

  describe "instance methods" do
    describe "#check_github" do
      let(:library) { build_stubbed(:library, :real) }

      it "parses description and star (popularity) data from GitHub API" do
        library.check_github
        expect(library.description).to_not be_nil
        expect(library.popularity).to_not be_nil
      end
    end

    describe "#check_any?" do
      let(:library) { build_stubbed(:library) }

      it "returns true when at least one of the check_* attributes is true" do
        library.check_description = true
        library.check_popularity  = true
        expect(library.check_any?).to be_truthy

        library.check_description = false
        expect(library.check_any?).to be_truthy

        library.check_description = true
        library.check_popularity  = false
        expect(library.check_any?).to be_truthy
      end

      it "returns false when none of the check_* attributes are true" do
        library.check_description = false
        library.check_popularity  = false
        expect(library.check_any?).to be_falsey
      end
    end

    describe "#approve" do
      let(:library) { create(:library, approved: false, active: false) }
      before { 5.times { create(:version, library: library, active: false) } }

      it "sets approved, active, check_* to true on library and its versions" do
        expect(library.approved).to be_falsey
        expect(library.active).to be_falsey
        expect(library.check_any?).to be_falsey
        
        library.approve
        
        expect(library.approved).to be_truthy
        expect(library.active).to be_truthy
        expect(library.check_description).to be_truthy
        expect(library.check_popularity).to be_truthy
        
        library.versions.each do |version|
          expect(version.active).to be_truthy
          expect(version.check_weight).to be_truthy
        end
      end
    end
  end
end
