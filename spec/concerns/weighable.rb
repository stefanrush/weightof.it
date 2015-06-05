require 'spec_helper'

shared_examples_for 'Weighable' do
  describe "respond to" do
    it { is_expected.to respond_to(:check_weight) }
  end

  def new_model
    build_stubbed(described_class.to_s.underscore.to_sym, :real)
  end

  let(:model) { new_model }
  let(:test_weight) { 97134 }

  describe "#weigh" do
    context "when :weight is blank" do
      it "sets weight to the filesize of the compressed file in bytes" do
        model.weigh
        expect(model.weight).to eq(test_weight)
      end
    end
  end
end
