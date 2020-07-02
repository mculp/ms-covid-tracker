require 'hanami/interactor'

class AddPreviousUpdates
  include Hanami::Interactor

  def call
    CountyRepository.new.all.each do |county|
      county_updates = CountyUpdateRepository.new.find_all_by_county_id(county.id).to_a

      county_updates.each_with_index do |county_update, index|
        break if index + 1 >= county_updates.size

        previous_update_id = county_updates[index + 1].id

        CountyUpdateRepository.new.update(county_update.id, previous_update_id: previous_update_id)
      end
    end
  end
end
