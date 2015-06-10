class LibrariesController < ApplicationController
  include Pagerable

  # GET '/(category/:slug)'
  def index
    @categories = Category.app_data
    @libraries  = Library.app_data
    
    @libraries_subset = subset @libraries.dup
  
  rescue ActiveRecord::RecordNotFound
    render_404
  end

private
  
  # Accepts collection of libraries
  # Returns subset of libraries based on params
  def subset(libraries)
    libraries = filter libraries
    libraries = search libraries
    libraries = sort libraries

    @original_count = libraries.to_a.size
    
    libraries = paginate libraries
    libraries
  end

  # Accepts collection of libraries
  # Returns filtered subset of libraries using :slug param
  def filter(libraries)
    if params[:slug]
      @category = @categories.find_by_slug! params[:slug]
      libraries = libraries.where(category: @category)
    end
    libraries
  end

  # Accepts collection of libraries
  # Returns searched subset of libraries using :search param
  def search(libraries)
    if params[:search]
      @search = params[:search]
      libraries = libraries.where('name ILIKE ?', "%#{@search}%")
    end
    libraries
  end

  # Accepts collection of libraries
  # Returns sorted libraries using :sort param
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
