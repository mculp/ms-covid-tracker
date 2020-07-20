module Api
  module Controllers
    module Counties
      class Index
        include Api::Action

        def call(params)
          @counties = CountyRepository.new.all_with_updates.to_a

          self.body = JSON.dump(build_hash)
          self.format = :json
        end

        # TODO: clean this up
        def build_hash
          @counties.map do |county|
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
                      cases: county_update.new_cases,
                      deaths: county_update.new_deaths,
                      ltc_cases: county_update.new_ltc_cases,
                      ltc_deaths: county_update.new_ltc_deaths
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
