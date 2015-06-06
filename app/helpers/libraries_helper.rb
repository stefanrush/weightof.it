module LibrariesHelper
  # Returns class for '.total-found' libraries element
  def total_class
    @libraries_subset.count > 0 ? nil : 'hidden'
  end

  # Returns class for '.none-found' libraries element
  def none_class
    @libraries_subset.count > 0 ? 'hidden' : nil
  end
end
