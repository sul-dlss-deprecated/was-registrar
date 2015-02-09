require 'was/registrar/register_object'

module Was
  module Registrar
    class RegisterSeedObject < RegisterObject
      
      def initalize
      end
      
      # Registers crawl object based on crawl item record
      # @param [Hash] crawl_item_hash is a hash that represents the crawl item
      # @raise [Error] if there is a missing parameters
      # @return [String] the druid id as retruned from the registering object
       def register seed_item_hash
        druid = nil

        register_params = convert_column_to_params(seed_item_hash)
        
        if is_valid?(register_params) then
          druid = register_object_using_web_service register_params
        else
          raise "Missing required parameters #{register_params}"
        end
        return druid
      end
      
      # @return [Boolean] true if the required parameters exist
      def is_valid? register_params
        if  register_params[:source_id].present? &&
            register_params[:collection].present? &&
            register_params[:label].present? 
            then
            return true
        end
        return false        
      end
      
      # Converts the database columns into params that could be passed to the registration service   
      def convert_column_to_params seed_item_hash
    
        register_params= {
            :object_type  => 'item',
            :admin_policy => Rails.configuration.apo,
            :source_id    => "#{seed_item_hash['source_id']}", #{Time.now.to_i}",
            :label        => seed_item_hash['title'].blank? ? seed_item_hash['uri'] : seed_item_hash['title'],
            :collection   => seed_item_hash['collection_id'],
            :initiate_workflow => "wasSeedPreassemblyWF",
          }
        register_params[:rights] = seed_item_hash['rights'].present? ? seed_item_hash['rights'] : nil

        return register_params
      end
      
    end
  end
end