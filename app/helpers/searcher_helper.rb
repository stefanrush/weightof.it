module SearcherHelper
  # Returns true if sort hidden_field should be included within searcher form
  def include_sort
    @sort && @sort != 'weight'
  end

  # Returns classes for '.clear' button element within searcher form
  def clear_classes
    classes = 'clear'
    classes << ' hidden' unless @search
    classes
  end
end
