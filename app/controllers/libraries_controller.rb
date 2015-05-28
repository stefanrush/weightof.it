class LibrariesController < ApplicationController
  def index
    @libraries  = Library.active
    @categories = Category.by_position
  end
end
