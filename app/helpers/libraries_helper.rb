module LibrariesHelper
  def total_class
    @libraries_subset.count > 0 ? nil : 'hidden'
  end

  def none_class
    @libraries_subset.count > 0 ? 'hidden' : nil
  end
end
