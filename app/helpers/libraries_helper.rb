module LibrariesHelper
  def all_category_link
    link_to "All Libraries", build_url(:slug, nil),
                             class: @category.nil? ? 'active' : nil,
                             data: { category: 'all' }
  end

  def category_link(category)
    link_to category.name, build_url(:slug, category.slug),
                           class: category == @category ? 'active' : nil,
                           data: { category: category.slug }
  end

  def sort_link(sort)
    link_to sort.capitalize, build_url(:sort, sort),
                             class: sort == @sort ? 'active' : nil,
                             data: { sort: sort }
  end

  def total_class
    @libraries_subset.count > 0 ? nil : 'hidden'
  end

  def none_class
    @libraries_subset.count > 0 ? 'hidden' : nil
  end
end
