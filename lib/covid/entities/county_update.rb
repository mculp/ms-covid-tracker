class CountyUpdate < Hanami::Entity
  def new_cases
    return unless previous_update

    cases - previous_update.cases
  end

  def new_deaths
    return unless previous_update

    deaths - previous_update.deaths
  end

  def new_ltc_cases
    return unless previous_update

    ltc_cases - previous_update.ltc_cases
  end

  def new_ltc_deaths
    return unless previous_update

    ltc_deaths - previous_update.ltc_deaths
  end

  def new_cases_percent_change
    return unless previous_update

    (new_cases.to_f / previous_update.cases.abs * 100).round(1)
  end
end
