class CountyRepository < Hanami::Repository
  associations do
    has_many :county_updates
  end

  def find_by_name(name)
    counties.where(name: name).one
  end

  def find_or_create_by_name(name)
    find_by_name(name) || create(name: name)
  end

  def all_with_updates
    aggregate(county_updates: :previous_update)
      .node(:county_updates) { |county_updates| county_updates.order(county_updates_date_desc) }
      .map_to(County)
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
