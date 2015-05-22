require 'spec_helper'

shared_examples_for 'Weighable' do
  describe "respond to" do
    it { is_expected.to respond_to(:weight) }
  end

  describe "validations" do
    it { is_expected.to validate_numericality_of(:weight).is_greater_than(0) }
  end

  def new_model
    build(described_class.to_s.underscore.to_sym, :real)
  end

  let(:model) { new_model }
  let(:test_weight) { 97134 }

  describe "#weigh" do
    it "sets weight to the filesize of the compressed file in bytes" do
      model.weigh
      expect(model.weight).to eq test_weight
    end
  end

  describe "#weight_kb" do
    it "returns weight in kilobytes" do
      model.weight = test_weight
      expect(model.weight_kb).to eq test_weight / 1000.0
    end
  end

  describe "#weight_mb" do
    it "returns weight in megabytes" do
      model.weight = test_weight
      expect(model.weight_mb).to eq test_weight / (1000 * 1000.0)
    end
  end

  describe "#weight_gb" do
    it "returns weight in gigabytes" do
      model.weight = test_weight
      expect(model.weight_gb).to eq test_weight / (1000 * 1000 * 1000.0)
    end
  end

  describe "#weight_pretty" do
    it "returns the weight as a string with sensible units" do
      model.weight = test_weight / 1000
      expect(model.weight_pretty).to eq "97 B"

      model.weight = test_weight
      expect(model.weight_pretty).to eq "97.1 KB"

      model.weight = test_weight * 1000.0
      expect(model.weight_pretty).to eq "97.1 MB"
    end
  end
end
