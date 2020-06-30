module Web
  module Controllers
    module Counties
      class Show
        include Web::Action

        expose :county

        def call(params)
          @county = CountyRepository.new.find_by_name_with_updates(params[:name])
        end
      end
    end
  end
end
