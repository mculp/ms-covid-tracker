module Api
  module Controllers
    module Counties
      class Index
        include Api::Action

        def call(params)
          @counties = CountyRepository.new.all_with_updates.to_a

          self.body = Api::Serializers::Counties::Index.new(@counties).to_json
          self.format = :json
        end
      end
    end
  end
end
