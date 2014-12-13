

module Was
  module Registrar
    class RegisterCrawlObject < RegisterObject
      def initalize
      end
      
      def register
        
      end
      
      def prepare_crawl_object_params job_label, collection_id
        params= {
            :object_type  => 'item', 
            :admin_policy => Rails.configuration.apo,
            :source_id    => "#{Time.now.to_i}",
            :label        => job_label,
            :collection   => collection_id,
            :initiate_workflow => "wasCrawlPreassemblyWF",
            :rights       => 'none',
        }
        return params
      end
    end
  end
end
