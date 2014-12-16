

module Was
  module Registrar
    class RegisterCrawlObject < RegisterObject
      def initalize
      end
      
      def register crawl_item_hash

        druid = nil
        params = convert_column_to_params( crawl_item_hash )
        druid = register_object_using_web_service params
        return druid

      end
      
      def convert_column_to_params crawl_item_hash
    
        params= {
            :object_type  => 'item', 
            :admin_policy => Rails.configuration.apo,
            :source_id    => crawl_item_hash['source_id'],
            :label        => crawl_item_hash['label'],
            :collection   => crawl_item_hash['collection_id'],
            :initiate_workflow => "wasCrawlPreassemblyWF",
            :rights       => "none",
          }

        return params
      end
 
    end
  end
end
