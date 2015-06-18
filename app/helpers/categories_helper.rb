module CategoriesHelper
  # Returns link element for 'All Libraries' category
  def all_category_link
    link_to "All Libraries", build_url(slug: nil),
                             class: @category.nil? ? 'active' : nil,
                             data: { category: 'all' }
  end

  # Accepts category
  # Returns link element for category
  def category_link(category)
    link_to category.name, build_url(slug: category.slug),
                           class: category == @category ? 'active' : nil,
                           data: { category: category.slug }
  end
end
