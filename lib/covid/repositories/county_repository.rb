class CountyRepository < Hanami::Repository
  associations do
    has_many :county_updates
  end

  def find_by_name(county_name)
    counties
      .where(counties[:name].func { string::replace(name, ' ', '') }.ilike(county_name.tr(' ', '')))
      .one
  end

  def find_or_create_by_name(name)
    find_by_name(name) || create(name: name)
  end

  def all_with_updates
    aggregate(county_updates: :previous_update)
      .node(:county_updates) { |county_updates| county_updates.order(county_updates_date_desc) }
      .map_to(County)
      .to_a
      .sort_by {
        |county| county.county_updates.first.cases - county.county_updates.first.previous_update&.cases
      }.reverse!
  end

  def all_with_updates_sorted_by_new_cases
    all_with_updates
      .sort_by {
        |county| county.county_updates.first.cases - county.county_updates.first.previous_update&.cases
      }.reverse!
  end

  def find_by_name_with_updates(name)
    aggregate(county_updates: :previous_update)
      .where(counties[:name].qualified => name.capitalize)
      .node(:county_updates) { |county_updates| county_updates.order(county_updates_date_desc) }
      .map_to(County)
      .one
  end

  def county_updates_date_desc
    county_updates[:date].qualified.desc
  end
end
