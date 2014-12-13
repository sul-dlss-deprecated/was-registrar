require 'was/registrar/register_object.rb'

module Was
  module Registrar
    class RegisterSeedObject < RegisterObject
      def initalize
      end
      
      #It will raise an exception if anything happenes during the registration process
      def register seed_item_hash
        druid = nil

        params = convert_column_to_params( seed_item_hash )
        
        if is_valid?(params) then
          druid = register_object_using_web_service params
        else
          raise "Missing required parameters #{params}"
        end
        return druid
      end
      
      
      def is_valid? params
        if  params[:source_id].nil? or params[:source_id].blank? or
            params[:collection].nil? or params[:collection].blank? or
            params[:label].nil? or params[:label].blank? then
            return false
        end
        return true        
      end
    
      def convert_column_to_params seed_item_hash
    
        params= {
            :object_type  => 'item', #It needs an update to Dor.registered_classes
        #    :content_type => 'webarchiving-seed',
            :admin_policy => Rails.configuration.apo,
            :source_id    => "#{seed_item_hash['source_id']}#{Time.now.to_i}",
            :label        => seed_item_hash['title'].blank? ? seed_item_hash['uri'] : seed_item_hash['title'],
            :collection   => seed_item_hash['collection_id'],
            :initiate_workflow => "wasSeedPreassemblyWF",
            

          }
          
        if seed_item_hash['rights'].nil? or seed_item_hash['rights'].blank? then
          params[:rights] = nil
        else 
           params[:rights] =seed_item_hash['rights']
        end
        return params
      end
      
    end
  end
end