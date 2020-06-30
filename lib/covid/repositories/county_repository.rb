class CountyRepository < Hanami::Repository
  def find_by_name(name)
    counties.where(name: name).first
  end

  def find_or_create_by_name(name)
    find_by_name(name) || create(name: name)
  end
end
