require 'hanami/interactor'

class ProcessCountyUpdate
  include Hanami::Interactor

  attr_reader :county_update

  def initialize(row)
    @county_name = county_update.keys.first
  end

  def call


    CountyUpdateRepository.new.create()
  end

  def new_totals
    {
      cases: hash[county.name][0],
      deaths: hash[county.name][1],
      ltc_cases: hash[county.name][2],
      ltc_deaths: hash[county.name][3]
    }
  end


  def county
    @county ||= CountyRepository.new.find_by_name(county_name)
  end

  def previous_county_update
    @previous_county_update ||= CountyUpdateRepository.new.find_latest_by_county_id(county.id)
  end
end
