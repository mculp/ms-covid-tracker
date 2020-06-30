class CountyUpdateRepository < Hanami::Repository
  def from_table_row_hash(hash)
    county = CountyRepository.new.find_or_create_by_name(hash.keys.first)

    attributes = {
      county_id: county.id,
      cases: hash[county.name][0],
      deaths: hash[county.name][1],
      ltc_cases: hash[county.name][2],
      ltc_deaths: hash[county.name][3]
    }

    create(attributes)
  end
end
