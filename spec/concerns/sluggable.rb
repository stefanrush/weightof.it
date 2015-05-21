require 'spec_helper'

shared_examples_for 'Sluggable' do
  let(:tests) do
    [
      "TEsT u*&^Rl-number   12345!!!",
      "ANOTHER---T*&E(*&S7",
      "    Y      E T__another-^T^E+ST"
    ]
  end

  let(:expectations) do
    [
      "test-url-number-12345",
      "another---tes7",
      "-y-e-t__another-test"
    ]
  end

  def new_model
    build(described_class.to_s.underscore.to_sym)
  end

  it "slugifies name when no slug is present" do
    test_names = tests
    expected_slugs = expectations

    test_names.zip(expected_slugs).each do |test_name, expected_slug|
      model = new_model
      model.name = test_name
      model.slug = nil
      model.save!
      model.reload
      expect(model.slug).to eq expected_slug
    end
  end

  it "slugifies slug when slug is present" do
    test_slugs = tests
    expected_slugs = expectations

    test_slugs.zip(expected_slugs).each do |test_slug, expected_slug|
      model = new_model
      model.slug = test_slug
      model.save!
      model.reload
      expect(model.slug).to eq expected_slug
    end
  end
end
