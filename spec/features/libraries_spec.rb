require 'spec_helper'

RSpec.describe "Libraries", type: :feature, js: true do
  def random_category
    Category.all[rand(Category.count)]
  end

  def library_items
    all('section.libraries ol.list li')
  end

  before(:each) do
    3.times  { create(:category) }
    10.times { create(:library, category: random_category) }
    visit root_path
  end

  describe "filter" do
    describe "by category" do
      it "filters libraries by category" do        
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

  describe "sorter" do
    describe "by weight" do
      it "sorts libraries by weight" do
        click_link "Popularity"
        click_link "Weight"

        Library.by_weight.zip(library_items).each do |library, library_item|
          expect(library_item.find('span.info')).to have_text library.name
        end
      end
    end

    describe "by popularity" do
      it "sorts libraries by popularity" do
        click_link "Popularity"

        Library.by_popularity.zip(library_items).each do |library, library_item|
          expect(library_item.find('span.info')).to have_text library.name
        end
      end
    end

    context "with filter" do
      describe "by popularity" do
        it "sorts filtered libraries by popularity" do
          category = random_category

          click_link category.name
          click_link "Popularity"

          Library.where(category: category)
                 .by_popularity
                 .zip(library_items)
                 .each do |library, library_item|
            expect(library_item.find('span.info')).to have_text library.name
          end
        end
      end
    end
  end

  describe "searcher" do
    it "searches libraries by name"
  end

  describe "pager" do

  end
end
