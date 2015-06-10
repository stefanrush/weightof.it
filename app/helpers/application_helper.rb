module ApplicationHelper
  # Accepts category (optional)
  # Returns title of page
  def title(category)
    title = "weightof.it"
    title << " - #{category.name}" if category
    title << " - Compare JavaScript libraries by weight (file size)"
  end

  # Accepts update params hash to write over current params
  # Returns new URL for current page using updated params
  def build_url(update)
    p = build_params(update)

    # Building the URL this way because I want the params in a certain order
    # url_for() orders params alphabetically because hashes are ordered
    new_url  = '/'
    new_url << "category/#{p[:slug]}"  if p[:slug]
    new_url << "?search=#{p[:search]}" if p[:search]
    if p[:sort] && p[:sort] != 'weight'
      new_url << (new_url =~ /\?/ ? '&' : '?')
      new_url << "sort=#{p[:sort]}"
    end
    if p[:page] && p[:page] != 1
      new_url << (new_url =~ /\?/ ? '&' : '?')
      new_url << "page=#{p[:page]}"
    end

    new_url
  end

  # Accepts update params hash to write over current params
  # Returns hash of overwritten parameters
  def build_params(update)
    new_params = {
      slug:   @category ? @category.slug : nil,
      search: @search,
      sort:   @sort,
      page:   nil
    }

    new_params[:slug]   = update[:slug]   if update.has_key? :slug
    new_params[:search] = update[:search] if update.has_key? :search    
    new_params[:sort]   = update[:sort]   if update.has_key? :sort

    if update.has_key? :page
      page = update[:page]
      page = 1           if page && page <= 1
      page = @page_count if page && page > @page_count
      new_params[:page] = page
    end

    new_params
  end
end
