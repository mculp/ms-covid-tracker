class CountyUpdateRepository < Hanami::Repository
  def from_table_row_hash(hash)

    create(attributes)
  end

  def find_latest_by_county_id(county_id)
    where(county_id: county_id).order(:date).first
  end
end
