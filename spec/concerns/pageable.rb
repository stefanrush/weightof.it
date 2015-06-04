require 'spec_helper'

shared_examples_for 'Pageable' do
  def new_model
    create(described_class.to_s.underscore.to_sym)
  end

  before(:all) do
    100.times { new_model }
  end

  describe ".per_page" do
    it "is the number of items per page" do
      expect(described_class).to respond_to(:per_page)
    end
  end

  describe ".page_count" do
    it "returns the number of pages" do
      per_page_tests     = [10, 20, 32, 42, 51, 89, 100, 101, 1000]
      pages_expectations = [10,  5,  4,  3,  2,  2,   1,   1,    1]

      per_page_tests.zip(pages_expectations) do |test, expectation|
        described_class.per_page = test
        expect(described_class.page_count).to eq(expectation)
      end
    end
  end

  describe ".page(number)" do
    it "returns only items from specific page" do
      described_class.per_page = 10

      collection = described_class.active

      10.times do
        page_number = rand(9) + 1 
        page_range  = (10 * (page_number - 1))..(10 * page_number)
        collection.page(page_number)
                  .zip(collection[page_range]).each do |test, expectation|
          expect(test.name).to eq(expectation.name)
        end
      end
    end
  end
 end
