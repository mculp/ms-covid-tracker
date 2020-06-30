module Web
  module Controllers
    module Counties
      class Index
        include Web::Action

        expose :counties

        def call(params)
          @counties = CountyRepository.new.all_with_latest_update
        end
      end
    end
  end
end
