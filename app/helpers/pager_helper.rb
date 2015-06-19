module PagerHelper
  # Returns list item element for current page
  def current_page
    content_tag :li, @page, class: 'current', title: current_page_title
  end

  # Returns title for '.current' page element 
  def current_page_title
    "Page #{@page} of #{@page_count}"
  end

  # Accepts name of page link element
  # Accepts page number of page link element
  # Accepts beginning boolean which determines whether page link element is
  #         first/previous element or next/last element
  # Accepts &block of content to be placed within page link element 
  # Returns page element
  def page_link(name, page, beginning, &block)
    name    = name.to_s
    classes = page_classes name, beginning
    title   = page_title name
    rel     = (name == 'next' || name == 'previous') ? name[0..3] : nil
    content_tag(:li, class: classes, title: title) do
      link_to build_url(page: page), class: 'button', rel: rel, data: { behavior: true } do
        yield block
      end
    end
  end

  # Accepts name of page link element
  # Accepts beginning boolean which determines whether page link element is
  #         first/previous element or next/last element
  # Returns classes for page link element
  def page_classes(name, beginning)
    classes = "#{name}"
    if beginning
      classes << ' disabled' if @page <= 1
    else
      classes << ' disabled' if @page >= @page_count
    end
    classes
  end

  # Accepts name of page link element
  # Returns page link element title
  def page_title(name)
    "#{name.capitalize} Page"
  end
end
