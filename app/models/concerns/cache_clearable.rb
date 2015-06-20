module CacheClearable
  extend ActiveSupport::Concern

  included do
    after_save    :clear_cache, if: :active?
    after_destroy :clear_cache

    def clear_cache
      ActionController::Base.expire_page('/')
    end
  end
end
