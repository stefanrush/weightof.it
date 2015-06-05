module SearcherHelper
  def include_sort
    @sort && @sort != 'weight'
  end

  def clear_classes
    classes = 'clear'
    classes << ' hidden' unless @search
    classes
  end
end
