require 'github_stars_checker'

module Popularable
  extend ActiveSupport::Concern

  included do
    validates :popularity, presence: true
    validates :popularity, numericality: { greater_than_or_equal_to: 0 }
    
    before_save :check_popularity

    def check_popularity
      self.popularity = GithubStarsChecker.new(source_url).check_stars
    end
  end
end
