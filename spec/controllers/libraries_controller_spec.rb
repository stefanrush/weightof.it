require 'spec_helper'

RSpec.describe LibrariesController, type: :controller do
  def random_category
    Category.all[rand(Category.count)]
  end

  before(:all) do
    3.times  { create(:category) }
    10.times { create(:library, category: random_category) }
  end

  describe "GET #index" do
    context "without category" do
      it "renders index template" do
        get :index
        expect(response.status).to eq(200)
        expect(response).to render_template :index
      end
    end

    context "with valid category" do
      it "renders index template" do
        get :index, slug: random_category.slug
        expect(response.status).to eq(200)
        expect(response).to render_template :index
      end
    end

    context "with invalid category" do
      it "renders 404" do
        invalid_category = build_stubbed(:category)
        get :index, slug: invalid_category.slug
        expect(response.status).to eq(404)
      end
    end
  end
end
