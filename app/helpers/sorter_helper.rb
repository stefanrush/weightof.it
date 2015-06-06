module SorterHelper
  # Accepts sort name (e.g. weight, popularity)
  # Returns sort link element
  def sort_link(sort)
    link_to sort.capitalize, build_url(sort: sort),
                             class: sort == @sort ? 'active' : nil,
                             data: { sort: sort }
  end
end
