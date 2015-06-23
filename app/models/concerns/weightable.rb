require 'pretty_weights'

module Weightable
  extend ActiveSupport::Concern

  included do
    validates :weight, numericality: { greater_than: 0 }, allow_blank: true
    validates :weight_gzipped, numericality: { greater_than: 0 }, allow_blank: true

    scope :weighed,   -> { where.not(weight: nil) }
    scope :unweighed, -> { where(weight: nil) }
    scope :by_weight, -> { order(:weight) }

    include PrettyWeights

    def weight_pretty
      prettify_weight(weight)
    end

    def weight_gzipped_pretty
      prettify_weight(weight_gzipped)
    end
  end
end
