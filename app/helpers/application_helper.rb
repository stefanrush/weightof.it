module ApplicationHelper
  def title(category)
    title = "weightof.it"
    title << " - #{category.name}" if category
    title << " - Compare JavaScript libraries by weight (file size)"
  end
end
