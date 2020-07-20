module Web
  module Views
    module Counties
      class Index
        include Web::View

        def updated
          CountyUpdateRepository.new.last.date.strftime("%B %d, %Y")
        end

        def badge_class(percent)
          if percent > 10
            'badge-danger'
          elsif percent > 5
            'badge-warning'
          else
            'badge-info'
          end
        end
      end
    end
  end
end
