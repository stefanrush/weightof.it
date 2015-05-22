require 'scale'

module Weighable
  extend ActiveSupport::Concern

  included do
    validates :weight, numericality: { greater_than: 0 }, allow_blank: true

    before_save :weigh

    def weigh
      self.weight = Scale.new.weigh(self)
    end

    def weight_kb
      weight / 1000.0
    end

    def weight_mb
      weight_kb / 1000.0
    end

    def weight_gb
      weight_mb / 1000.0
    end

    def weight_pretty
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
