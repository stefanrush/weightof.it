require 'scale'

module Weighable
  extend ActiveSupport::Concern

  included do
    before_validation :weigh, if: :check_weight

    def weigh
      self.weight = Scale.new(raw_url).weigh
      self.check_weight = false
    end
  end
end
