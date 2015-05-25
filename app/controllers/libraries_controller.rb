class LibrariesController < ApplicationController
  def index
    @libraries  = Library.by_weight
    @categories = Category.by_position
  end
end
