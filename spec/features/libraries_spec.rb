require 'spec_helper'

RSpec.describe "Libraries", type: :feature, js: true do
  def random_category
    Category.all[rand(Category.count)]
  end

  def search_results(query, libraries=Library)
    libraries.where('name LIKE ?', "%#{query}%")
  end

  def trigger_search
    page.driver.execute_script "$('#search').trigger('keyup');"
  end

  def library_items
    all('section.libraries ol.list li')
  end

  before do
    4.times  { create(:category) }
    20.times { create(:library, category: random_category) }
    visit root_path
  end

  describe "filter" do
    describe "by category" do
      it "filters libraries by category" do        
        Category.by_position.each do |category|
          library_count = Library.where(category: category).count
          click_link category.name
          
          expect(library_items.size).to eq(library_count)
        end

        click_link "All Libraries"
        
        expect(library_items.size).to eq(Library.count)
      end

      context "with sort" do
        it "filters sorted libraries by category" do
          category = random_category

          click_link "Popularity"
          click_link category.name

          Library.where(category: category)
                 .by_popularity
                 .zip(library_items)
                 .each do |library, library_item|
            expect(library_item.find('span.info')).to have_text(library.name)
          end
        end
      end
      
      context "with search" do
        it "filters searched libraries by category" do
          query = "1"
          fill_in :search, with: query
          trigger_search

          Category.by_position.each do |category|
            click_link category.name
            libraries = search_results(query, Library.where(category: category))
            
            expect(library_items.size).to eq(libraries.count)
          end
        end
      end
    end
  end

  describe "sorter" do
    describe "by weight" do
      it "sorts libraries by weight" do
        click_link "Popularity"
        click_link "Weight"

        Library.by_weight.zip(library_items).each do |library, library_item|
          expect(library_item.find('span.info')).to have_text(library.name)
        end
      end
    end

    describe "by popularity" do
      it "sorts libraries by popularity" do
        click_link "Popularity"

        Library.by_popularity.zip(library_items).each do |library, library_item|
          expect(library_item.find('span.info')).to have_text(library.name)
        end
      end
    end
  end

  describe "searcher" do
    it "searches libraries by name" do
      query = "1"
      fill_in :search, with: query
      trigger_search

      expect(library_items.size).to eq(search_results(query).count)
    end
  end

  describe "pager" do

  end
end
