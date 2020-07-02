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
    county = CountyRepository.new.find_or_create_by_name(row.keys.first)

    previous_update = find_latest_by_county_id(county.id)

    attributes = {
      date: date,
      county_id: county.id,
      cases: row[county.name][0],
      deaths: row[county.name][1],
      ltc_cases: row[county.name][2],
      ltc_deaths: row[county.name][3]
    }

    attributes[:previous_update_id] = previous_update.id if previous_update

    create(attributes)
  end

  def find_with_previous_updates
    aggregate(:previous_update).map_to(CountyUpdate)
  end
end
