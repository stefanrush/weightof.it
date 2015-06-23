require 'spec_helper'

shared_examples_for 'Weightable' do
  describe "respond to" do
    it { is_expected.to respond_to(:weight) }
    it { is_expected.to respond_to(:weight_gzipped) }
  end

  describe "validations" do
    it { is_expected.to validate_numericality_of(:weight).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:weight_gzipped).is_greater_than(0) }
  end

  def new_model
    build_stubbed(described_class.to_s.underscore.to_sym, :real)
  end

  let(:model) { new_model }
  let(:test_weight) { 97134 }

  describe "#weight_pretty" do
    it "returns the weight as a string with sensible units" do
      model.weight = test_weight / 1000
      expect(model.weight_pretty).to eq("97 B")

      model.weight = test_weight
      expect(model.weight_pretty).to eq("97.1 KB")

      model.weight = test_weight * 1000.0
      expect(model.weight_pretty).to eq("97.13 MB")
    end
  end

  describe "#weight_gzipped_pretty" do
    it "returns the weight as a string with sensible units" do
      model.weight_gzipped = test_weight / 1000
      expect(model.weight_gzipped_pretty).to eq("97 B")

      model.weight_gzipped = test_weight
      expect(model.weight_gzipped_pretty).to eq("97.1 KB")

      model.weight_gzipped = test_weight * 1000.0
      expect(model.weight_gzipped_pretty).to eq("97.13 MB")
    end
  end
end
