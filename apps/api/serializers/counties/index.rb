module Api
  module Serializers
    module Counties
      class Index
        attr_reader :counties

        def initialize(counties)
          @counties = counties
        end

        def to_json
          JSON.dump(to_h)
        end

        def to_h
          counties.map do |county|
            {
              county: {
                name: county.name,
                updates: county.county_updates.map do |county_update|
                  county_update_hash = {
                    date: county_update.date.to_date,
                    total: {
                      cases: county_update.cases,
                      deaths: county_update.deaths,
                      ltc_cases: county_update.ltc_cases,
                      ltc_deaths: county_update.ltc_deaths
                    }
                  }

                  if county_update.previous_update
                    county_update_hash[:new] = {
                      cases: county_update.cases - county_update.previous_update.cases,
                      deaths: county_update.deaths - county_update.previous_update.deaths,
                      ltc_cases: county_update.ltc_cases - county_update.previous_update.ltc_cases,
                      ltc_deaths: county_update.ltc_deaths - county_update.previous_update.ltc_deaths
                    }
                  end

                  county_update_hash
                end
              }
            }
          end
        end
      end
    end
  end
end
