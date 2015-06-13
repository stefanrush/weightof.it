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

  # GET '/contribute'
  def new
    @library = Library.new
    @library.versions.build
  end
  
  # POST '/contribute'
  def create
    @library = Library.new(library_params)
    if verify_recaptcha(model: @library) && @library.save
      flash.notice = "Thank you for your contribution!"
      redirect_to root_url
    else
      errors = "The form contained the following errors: "
      errors << @library.errors.full_messages.join(', ')
      flash.now.alert = errors
      render :new
    end
  end

private
  
  def library_params
    params.require(:library).permit(
      :name,
      :source_url,
      :homepage_url,
      :category_id,
      versions_attributes: [
        :number,
        :raw_url
      ]
    )
  end

  # Accepts collection of libraries
  # Returns subset of libraries based on params
  def subset(libraries)
    libraries = filter libraries
    libraries = search libraries
    libraries = sort libraries

    @total_count = libraries.to_a.size
    
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
