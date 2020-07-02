module Api
  module Controllers
    module Counties
      class Show
        include Api::Action

        def call(params)
          county = CountyRepository.new.find_by_name_with_updates(params[:name])
          self.body = JSON.dump(county.to_h)
          self.format = :json
        end
      end
    end
  end
end
