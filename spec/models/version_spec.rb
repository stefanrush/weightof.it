# == Schema Information
#
# Table name: versions
#
#  id             :integer          not null, primary key
#  library_id     :integer          not null
#  number         :string           not null
#  file_url       :string           not null
#  weight         :integer
#  check_weight   :boolean          default(FALSE), not null
#  active         :boolean          default(FALSE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  weight_gzipped :integer
#

require 'spec_helper'

RSpec.describe Version, type: :model do
  describe "respond to" do
    it { is_expected.to respond_to(:library) }
    it { is_expected.to respond_to(:number) }
    it { is_expected.to respond_to(:file_url) }
    it { is_expected.to respond_to(:check_weight) }
    it { is_expected.to respond_to(:active) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:library) }
  end
  
  describe "validations" do
    it { is_expected.to validate_presence_of(:library) }
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:file_url) }

    it { is_expected.to_not allow_value('invalid-url!').for(:file_url) }
    it { is_expected.to_not allow_value('http://raw.com/raw').for(:file_url) }
    it { is_expected.to allow_value('http://raw.com/raw.js').for(:file_url) }
  end

  it_behaves_like "Weightable"

  describe "instance methods" do
    describe "#weigh" do
      let(:version) { build_stubbed(:version, :real) }
      let(:test_weight) { 97134 }

      it "sets weight to the filesize of the compressed file in bytes" do
        version.weigh
        expect(version.weight).to eq(test_weight)
        expect(version.weight_gzipped).to be < version.weight
      end
    end

    describe "#update_library_weight" do
      let(:library) { create(:library) }
      let(:version) { create(:version, library: library) }

      it "updates the the weight of the associated library to the weight of the version" do
        new_weight = 55
        version.update_attributes(weight: new_weight)
        version.update_library_weight
        expect(library.weight).to eq(new_weight)
      end
    end

    describe "#is_latest?" do
      let(:library)   { create(:library) }
      let(:version_a) { create(:version, library: library) }
      let(:version_b) { create(:version, library: library) }

      it "returns true when it is the latest version" do
        version_a.update_attributes(number: (version_b.number.to_f + 1).to_s)
        expect(version_a.is_latest?).to be_truthy
      end

      it "returns false when it isn't the latest version" do
        version_a.update_attributes(number: (version_b.number.to_f - 1).to_s)
        expect(version_a.is_latest?).to be_falsey
      end
    end

    describe "#sortable_number" do
      let(:version) { build_stubbed(:version) }
      let(:tests) do
        ["0.0.0",           "12.345.6789",     "1000.99.0",       "98765.4.321"]
      end
      let(:expectations) do
        ["000000000000000", "000120034506789", "010000009900000", "987650000400321"]
      end

      it "returns the version number in a sortable string format" do
        tests.zip(expectations).each do |test, expectation|
          version.number = test
          expect(version.sortable_number).to eq(expectation)
        end
      end
    end
  end
end
