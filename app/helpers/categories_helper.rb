module CategoriesHelper
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
end
