module Web
  module Views
    module Counties
      class Index
        include Web::View

        def updated
          CountyUpdateRepository.new.last.date.strftime("%B %d, %Y")
        end
      end
    end
  end
end
