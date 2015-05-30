require 'spec_helper'

RSpec.describe "Libraries", type: :feature do
  def random_category
    Category.find(rand(Category.count) + 1)
  end

  def library_items
    all('section.libraries ol.list li')
  end

  before(:all) do
    3.times  { create(:category) }
    20.times { create(:library, category: random_category) }
  end

  describe "filter", js: true do
    describe "by category" do
      it "filters libraries by category" do
        visit root_path
        
        Category.by_position.each do |category|
          library_count = Library.where(category: category).count
          click_link category.name
          expect(library_items.size).to eq library_count
        end

        click_link "All Libraries"
        expect(library_items.size).to eq Library.count
      end
    end
  end

  describe "sorter", js: true do
    describe "by weight" do
      it "sorts libraries by weight"
    end

    describe "by popularity" do
      it "sorts libraries by popularity"
    end
  end

  describe "searcher", js: true do
    it "searches libraries by name"
  end

  describe "pager", js: true do

  end
end
