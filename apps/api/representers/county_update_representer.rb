require 'roar/decorator'
require 'roar/json'

module Api
  module Representers
    class CountyUpdateRepresenter < Roar::Decorator
      include Roar::JSON

      property :cases
      property :deaths
      property :previous_update, extend: CountyUpdateRepresenter, class: CountyUpdate
    end
  end
end
