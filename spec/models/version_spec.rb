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

require 'spec_helper'

RSpec.describe Version, type: :model do
  describe "respond to" do
    it { is_expected.to respond_to(:library) }
    it { is_expected.to respond_to(:number) }
    it { is_expected.to respond_to(:raw_url) }
    it { is_expected.to respond_to(:check_weight) }
    it { is_expected.to respond_to(:active) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:library) }
  end
  
  describe "validations" do
    it { is_expected.to validate_presence_of(:library) }
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:raw_url) }

    it { is_expected.to_not allow_value('invalid-url!').for(:raw_url) }
    it { is_expected.to_not allow_value('http://raw.com/raw').for(:raw_url) }
    it { is_expected.to allow_value('http://raw.com/raw.js').for(:raw_url) }
  end

  it_behaves_like 'Weightable'

  let(:version) { build_stubbed(:version, :real) }
  
  describe "#weigh" do
    let(:test_weight) { 97134 }

    it "sets weight to the filesize of the compressed file in bytes" do
      version.weigh
      expect(version.weight).to eq(test_weight)
    end
  end

  describe "#update_library_weight" do
    it "updates the the weight of the associated library to the weight of the version"
  end

  describe "#is_latest?" do
    it "returns true it the version is the latest"
  end
end
