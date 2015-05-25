module LibrariesHelper
  def basic_info(library)
    text = "#{library.name}"
    text << " &mdash; #{library.description}" if library.description.present?
    content_tag :span, text.html_safe, class: 'info'
  end

  def homepage_link(library)
    link_to "Homepage", library.homepage_url, target: '_blank',
                                              class: 'button button-primary'
  end

  def source_link(library)
    link_to "Source", library.source_url, target: '_blank', class: 'button'
  end
end
