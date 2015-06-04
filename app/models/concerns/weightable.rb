module Weightable
  extend ActiveSupport::Concern

  included do
    validates :weight, numericality: { greater_than: 0 }, allow_blank: true

    scope :by_weight, -> { order(:weight) }

    def weight_kb
      return nil unless weight
      weight / 1000.0
    end

    def weight_mb
      return nil unless weight
      weight_kb / 1000.0
    end

    def weight_gb
      return nil unless weight
      weight_mb / 1000.0
    end

    def weight_pretty
      return nil unless weight
      case weight
      when 0..999
        "#{weight} B"
      when 1000..(1e6 - 1)
        "#{weight_kb.round(1)} KB"
      when 1e6..(1e9 - 1)
        "#{weight_mb.round(1)} MB"
      else
        "#{weight_gb.round(1)} GB"
      end
    end
  end
end
