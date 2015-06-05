class LibrariesController < ApplicationController
  include Pagerable

  def index
    @categories = Category.by_position
    @libraries  = Library.active
    
    @libraries_subset = subset @libraries.dup
  
  rescue ActiveRecord::RecordNotFound
    render_404
  end

private
  
  def subset(libraries)
    libraries = filter libraries
    libraries = search libraries
    libraries = sort libraries

    @original_count = libraries.count
    
    libraries = paginate libraries
    libraries
  end

  def filter(libraries)
    if params[:slug]
      @category = @categories.find_by_slug! params[:slug]
      libraries = libraries.where(category: @category)
    end
    libraries
  end

  def search(libraries)
    if params[:search]
      @search = params[:search]
      libraries = libraries.where('name ILIKE ?', "%#{@search}%")
    end
    libraries
  end

  def sort(libraries)
    @sort = params[:sort] || 'weight'
    case @sort
    when 'popularity'
      libraries = libraries.by_popularity
    when 'weight'
      libraries = libraries.by_weight
    else # invalid sort parameter
      raise ActiveRecord::RecordNotFound
    end
    libraries
  end
end
