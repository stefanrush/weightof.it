class LibrariesController < ApplicationController
  def index
    @libraries  = Library.active
    @categories = Category.by_position
    @category   = @categories.find_by_slug(params[:slug]) if params[:slug]
  end
end
