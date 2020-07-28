class CountyUpdateRepository < Hanami::Repository
  associations do
    belongs_to :county
    belongs_to :county_update, as: :previous_update
  end

  def find_all_by_county_id(county_id)
    county_updates.where(county_id: county_id).order(county_updates[:date].qualified.desc)
  end

  def find_latest_by_county_id(county_id)
    find_all_by_county_id(county_id).limit(1).one
  end

  def find_previous_update_for(county_id:, date:)
    county_updates.where(county_id: county_id, date: date).order(county_updates[:date].qualified)
  end

  def create_from_row(row:, date:)
    county_name = row.keys.first
    county = CountyRepository.new.find_by_name(county_name)

    return unless county

    previous_update = find_latest_by_county_id(county.id)

    attributes = {
      date: date,
      county_id: county.id,
      cases: row[county_name][0].to_i,
      deaths: row[county_name][1].to_i,
      ltc_cases: row[county_name][2] || previous_update&.ltc_cases,
      ltc_deaths: row[county_name][3] || previous_update&.ltc_deaths
    }

    attributes[:previous_update_id] = previous_update.id if previous_update

    create(attributes)
  end

  def find_with_previous_updates
    aggregate(:previous_update).map_to(CountyUpdate)
  end
end
