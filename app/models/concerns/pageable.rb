module Pageable
  extend ActiveSupport::Concern

  included do
    class_attribute :per_page
    self.per_page = Figaro.env.default_per_page.to_i

    scope :page,       -> (n) { limit(per_page).offset(per_page * (n - 1)) }
    scope :page_count, ->     { (count / self.per_page.to_f).ceil }
  end
end
