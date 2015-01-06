require 'was/registrar/register_object.rb'


module Was
  module Registrar
    
    # Registers crawl object
    class RegisterCrawlObject < RegisterObject
      def initalize
      end
      
      # Registers crawl object based on crawl item record
      # @param [Hash] crawl_item_hash is a hash that represents the crawl item
      # @raise [Error] if there is a missing parameters
      # @return [String] the druid id as retruned from the registering object
      def register crawl_item_hash

        params = convert_column_to_params( crawl_item_hash )
        if is_valid?(params) then
          druid = register_object_using_web_service params
        else
          raise "Missing required parameters #{params}"
        end
        return druid

      end
      
      # @return [Boolean] true if the required parameters exist
      def is_valid? params
        if  params[:source_id].nil? or params[:source_id].blank? or
            params[:label].nil? or params[:label].blank? or
            params[:collection].nil? or params[:collection].blank? then
            return false
        end
        return true        
      end
      
      # Converts the database columns into params that could be passed to the registration service   
      def convert_column_to_params crawl_item_hash
        params= {
            :object_type  => 'item', 
            :admin_policy => Rails.configuration.apo,
            :source_id    => crawl_item_hash['source_id'],
            :label        => crawl_item_hash['job_directory'],
            :collection   => crawl_item_hash['collection_id'],
            :initiate_workflow => "wasCrawlPreassemblyWF",
            :rights       => "none",
          }

        return params
      end
 
    end
  end
end
