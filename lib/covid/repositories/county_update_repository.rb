class CountyUpdateRepository < Hanami::Repository
  associations do
    belongs_to :county
  end

  def find_latest_by_county_id(county_id)
    where(county_id: county_id).order(:date).first
  end
end
