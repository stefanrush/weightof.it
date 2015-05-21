module Sluggable
  extend ActiveSupport::Concern

  included do
    validates :slug, presence: true

    before_validation :create_slug

    def create_slug
      return if name.blank?
      new_slug = slug.blank? ? name : slug
      # strip non-alphanumerics and replace spaces with hyphens
      self.slug = new_slug.downcase.gsub(/[^\w\-\s]+/, '').gsub(/\s+/, '-')
    end
  end
end
