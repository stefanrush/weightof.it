module SorterHelper
  def sort_link(sort)
    link_to sort.capitalize, build_url(:sort, sort),
                             class: sort == @sort ? 'active' : nil,
                             data: { sort: sort }
  end
end
