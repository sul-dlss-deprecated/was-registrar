# frozen_string_literal: true

require 'was/registrar/register_object'

module Was
  module Registrar
    # Registers crawl object
    class RegisterCrawlObject < RegisterObject
      # Converts the database columns into params that could be passed to the registration service   
      def convert_column_to_params crawl_item_hash
        register_params = { :object_type => 'item', 
                            :admin_policy => crawl_item_hash['apo_id'],
                            :source_id => crawl_item_hash['source_id'],
                            :label => crawl_item_hash['job_directory'],
                            :collection => crawl_item_hash['collection_id'],
                            :initiate_workflow => 'wasCrawlPreassemblyWF',
                            :rights => 'dark' }
        return register_params
      end
    end
  end
end
