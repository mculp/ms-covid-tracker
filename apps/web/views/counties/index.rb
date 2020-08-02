module Web
  module Views
    module Counties
      class Index
        include Web::View

        def updated
          CountyUpdateRepository.new.find_latest_by_county_id(1).date.strftime("%B %-d, %Y")
        end

        def badge_class(percent)
          if percent >= 4
            'badge-danger'
          elsif percent >= 2
            'badge-warning'
          else
            'badge-info'
          end
        end
      end
    end
  end
end
