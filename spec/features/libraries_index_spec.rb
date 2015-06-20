require 'spec_helper'

RSpec.describe "Libraries index", type: :feature do
  def random_category
    Category.all[rand(Category.count)]
  end

  def search_results(query, libraries=Library)
    libraries.where('name LIKE ?', "%#{query}%")
  end

  def click_category(name)
    within('section.content') { click_link name }
  end

  def library_items
    all('section.libraries ol.list li')
  end

  before(:all) { Library.per_page = 100 }

  before do
    4.times  { create(:category) }
    20.times { create(:library, category: random_category) }
    visit root_path
  end

  with_and_without_js do
    describe "filter" do
      describe "by category" do
        it "filters libraries by category" do        
          Category.by_position.each do |category|
            library_count = Library.where(category: category).count
            click_category category.name
            
            expect(library_items.size).to eq(library_count)
          end

          click_category "All Libraries"
          
          expect(library_items.size).to eq(Library.count)
        end

        context "with sort" do
          it "filters sorted libraries by category" do
            category = random_category

            click_link "Popularity"
            click_category category.name

            filtered = Library.where(category: category)
            sorted   = filtered.by_popularity

            sorted.zip(library_items).each do |library, library_item|
              expect(library_item.find('span.info')).to have_text(library.name)
            end
          end
        end

        context "with search" do
          it "filters searched libraries by category" do
            category = random_category
            query    = "1"

            fill_in :search, with: query
            click_button "Search"
            click_category category.name

            filtered = Library.where(category: category).by_weight
            searched = search_results(query, filtered)

            searched.zip(library_items).each do |library, library_item|
              expect(library_item.find('span.info')).to have_text(library.name)
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

          sorted = Library.by_weight

          sorted.zip(library_items).each do |library, library_item|
            expect(library_item.find('span.info')).to have_text(library.name)
          end
        end
      end

      describe "by popularity" do
        it "sorts libraries by popularity" do
          click_link "Popularity"

          sorted = Library.by_popularity

          sorted.zip(library_items).each do |library, library_item|
            expect(library_item.find('span.info')).to have_text(library.name)
          end
        end
      end

      describe "by name" do
        it "sorts libraries by name" do
          click_link "Name"

          sorted = Library.by_name

          sorted.zip(library_items).each do |library, library_item|
            expect(library_item.find('span.info')).to have_text(library.name)
          end
        end
      end
    end

    describe "searcher" do
      it "searches libraries by name" do
        query = "1"
        fill_in :search, with: query
        click_button "Search"

        searched = search_results(query)

        expect(library_items.size).to eq(searched.count)
      end
    end

    describe "pager" do
      before { Library.per_page = 3 }
      after  { Library.per_page = 100 }

      it "pages libraries one page at a time" do
        visit root_path

        (1..Library.page_count).each do |page|
          paged = Library.by_weight.page(page)

          paged.zip(library_items).each do |library, library_item|
            expect(library_item.find('span.info')).to have_text(library.name)
          end

          find('section.libraries ol.pager li.next a').click
        end
      end

      it "jumps to the first and last page of libraries" do
        visit root_path

        find('section.libraries ol.pager li.last a').click

        paged = Library.by_weight.page(Library.page_count)

        paged.zip(library_items).each do |library, library_item|
          expect(library_item.find('span.info')).to have_text(library.name)
        end

        find('section.libraries ol.pager li.first a').click

        paged = Library.by_weight.page(1)

        paged.zip(library_items).each do |library, library_item|
          expect(library_item.find('span.info')).to have_text(library.name)
        end
      end
    end
  end
end
