module ApplicationHelper
  def title(category)
    title = "weightof.it"
    title << " - #{category.name}" if category
    title << " - Compare JavaScript libraries by weight (file size)"
  end

  def build_url(key=nil, value=nil)
    if key == :slug
      slug = value
    else
      slug = @category.slug if @category
    end

    if key == :sort 
      sort = value
    else
      sort = @sort if @sort
    end
    sort = nil if sort == 'weight'

    page = value       if key == :page
    page = nil         if page && page <= 1
    page = @page_count if page && page > @page_count

    # I'm aware there are better ways to do this like url_for()
    # I'm just picky about the order of the params url_for() alphabetizes them

    new_url  = '/'
    new_url << "category/#{slug}"  if slug
    new_url << "?search=#{@query}" if @query
    if sort
      new_url << (@query ? '&' : '?')
      new_url << "sort=#{sort}"
    end
    if page
      new_url << ((@query || sort) ? '&' : '?')
      new_url << "page=#{page}"
    end

    new_url
  end
end
