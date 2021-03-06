# frozen_string_literal: true

require 'was/registrar/register_object'

module Was
  module Registrar
    class RegisterSeedObject < RegisterObject
      # Converts the database columns into params that could be passed to the registration service
      def convert_column_to_params(seed_item_hash)
        register_params = { object_type: 'item',
                            source_id: seed_item_hash['source_id'],
                            collection: seed_item_hash['collection_id'],
                            label: seed_item_hash['title'].presence || seed_item_hash['uri'],
                            admin_policy: seed_item_hash['apo_id'].presence || Settings.seed_apo }
        register_params[:rights] = seed_item_hash['rights'].presence

        register_params
      end
    end
  end
end
