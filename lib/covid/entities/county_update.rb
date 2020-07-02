class CountyUpdate < Hanami::Entity
  def diff
    Diff.new()
  end

  def previous_update
    @previous_update ||= CountyUpdateRepository.new.find_previous_update_for(county_id: county_id, date: date)
  end
end
