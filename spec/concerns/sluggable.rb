require 'spec_helper'

shared_examples_for 'Sluggable' do
  describe "respond to" do
    it { is_expected.to respond_to(:slug) }
  end

  describe "validation" do
    it { is_expected.to validate_presence_of(:slug) }
  end

  def new_model
    build(described_class.to_s.underscore.to_sym)
  end

  let(:tests) do
    [
      "TEsT   u*&^Rl-number    12345!!",
      "ANOTHER---T*&E(*&S^7           ",
      "_ - Y      E T__another-^T^E+ST"
    ]
  end

  let(:expectations) do
    [
      "test-url-number-12345",
      "another-tes7",
      "y-e-t-another-test"
    ]
  end

  describe "#slugify" do
    it "slugifies name when slug is blank" do
      tests.zip(expectations).each do |test_name, expected_slug|
        model = new_model
        model.name = test_name
        model.slug = nil
        model.save!
        model.reload
        expect(model.slug).to eq expected_slug
      end
    end

    it "slugifies slug when slug is present" do
      tests.zip(expectations).each do |test_slug, expected_slug|
        model = new_model
        model.slug = test_slug
        model.save!
        model.reload
        expect(model.slug).to eq expected_slug
      end
    end
  end
end
