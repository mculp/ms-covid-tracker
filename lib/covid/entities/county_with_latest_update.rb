class CountyWithLatestUpdate < Hanami::Entity
  def percent_change
    (new_cases.to_f / (cases - new_cases).abs * 100).round(1)
  end
end
