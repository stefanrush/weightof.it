module PrettyWeights
  def prettify_weight(weight)
    return nil unless weight
    case weight
    when 0..999
      "#{weight} B"
    when 1000..(1e6 - 1)
      "#{weight_kb(weight).round(1)} KB"
    when 1e6..(1e9 - 1)
      "#{weight_mb(weight).round(2)} MB"
    else
      "#{weight_gb(weight).round(3)} GB"
    end
  end

  def weight_kb(weight)
    return nil unless weight
    weight / 1000.0
  end

  def weight_mb(weight)
    return nil unless weight
    weight_kb(weight) / 1000.0
  end

  def weight_gb(weight)
    return nil unless weight
    weight_mb(weight) / 1000.0
  end
end
