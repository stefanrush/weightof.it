module Sluggable
  extend ActiveSupport::Concern

  included do
    validates :slug, presence: true

    before_validation :slugify

    def slugify
      return if name.blank?
      new_slug = slug.blank? ? name : slug
      # strip non-alphanumerics and replace spaces/underscores with hyphens
      self.slug = new_slug.downcase
                          .gsub(/\A[\s\_\-]+|[^\w\-\s]+|[\s\_\-]+\z/, '')
                          .gsub(/[\s\_\-]+/, '-')
    end
  end
end
