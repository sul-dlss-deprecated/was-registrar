require 'was/registrar/register_object'

module Was
  module Registrar
    class RegisterSeedObject < RegisterObject
      
      # Converts the database columns into params that could be passed to the registration service   
      def convert_column_to_params seed_item_hash
        register_params= {
            :object_type  => 'item',
            :source_id    => seed_item_hash['source_id'],
            :collection   => seed_item_hash['collection_id'],
            :label        => seed_item_hash['title'].blank? ? seed_item_hash['uri'] : seed_item_hash['title'],
            :admin_policy => seed_item_hash['apo_id'].blank? ? Rails.configuration.seed_apo : seed_item_hash['apo_id'],
            :initiate_workflow => "wasSeedPreassemblyWF",
          }
        register_params[:rights] = seed_item_hash['rights'].present? ? seed_item_hash['rights'] : nil

        return register_params
      end
      
    end
  end
end