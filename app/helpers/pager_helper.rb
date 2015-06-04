module PagerHelper
  def current_page
    content_tag :li, @page, class: 'current', title: current_page_title
  end

  def current_page_title
    "Page #{@page} of #{@page_count}"
  end

  def page_link(name, page, first, &block)
    name    = name.to_s
    classes = page_classes name, first
    title   = page_title name
    content_tag(:li, class: classes, title: title) do
      link_to build_url(:page, page), class: 'button', data: { behavior: true } do
        yield block
      end
    end
  end

  def page_classes(name, first)
    classes = "#{name}"
    if first
      classes << ' disabled' if @page <= 1
    else
      classes << ' disabled' if @page >= @page_count
    end
    classes
  end

  def page_title(name)
    "#{name.capitalize} Page"
  end
end
