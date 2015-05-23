require 'spec_helper'

shared_examples_for 'Popularable' do
  describe "respond to" do
    it { is_expected.to respond_to(:popularity) }
  end

  describe "validation" do
    it { is_expected.to validate_presence_of(:popularity) }
    it { is_expected.to validate_numericality_of(:popularity).is_greater_than_or_equal_to(0) }
  end

  def new_model
    build_stubbed(described_class.to_s.underscore.to_sym, :real)
  end

  let(:model) { new_model }

  describe "#check_popularity" do
    it "sets popularity to the number of stars on the GitHub repo" do
      model.check_popularity
      expect(model.popularity).to be > 0
    end
  end
end
