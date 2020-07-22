module Web
  module Controllers
    module Counties
      class Index
        include Web::Action

        expose :counties

        def call(params)
          @counties = CountyWithLatestUpdateRepository.new.all
        end
      end
    end
  end
end
