module SorterHelper
  # Accepts sort name (e.g. weight, popularity) and a link title
  # Returns sort link element
  def sort_link(sort, title=nil)
    link_to sort.capitalize, build_url(sort: sort),
                             class: sort == @sort ? 'active' : nil,
                             title: title,
                             data: { sort: sort }
  end
end
