class CountyRepository < Hanami::Repository
  associations do
    has_many :county_updates
  end

  def find_by_name(name)
    counties.where(name: name).first
  end

  def find_or_create_by_name(name)
    find_by_name(name) || create(name: name)
  end

  def all_with_latest_update
    aggregate(:county_updates).map_to(County)
  end
end
