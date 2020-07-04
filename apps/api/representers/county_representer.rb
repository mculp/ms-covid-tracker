require 'roar/decorator'
require 'roar/json'
require_relative 'county_update_representer'

module Api
  module Representers
    class CountyRepresenter < Roar::Decorator
      include Roar::JSON

      self.representation_wrap = :county

      property :name
      collection :county_updates, extend: Api::Representers::CountyUpdateRepresenter, class: CountyUpdate
    end
  end
end
