module Pagerable
  extend ActiveSupport::Concern

  def paginate(items)
    @page       = (params[:page] || 1).to_i
    @page_count = items.page_count
    @per_page   = items.model.per_page

    if items.count > 0 && (@page < 1 || @page > @page_count) # page doesn't exist
      raise ActiveRecord::RecordNotFound
    end

    items.page @page
  end
end
