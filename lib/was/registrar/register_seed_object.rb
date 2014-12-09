module Was
  module Registrar
    class RegisterSeedObject
  
      def initalize
      end
 
      def register seed_item_hash
        druid = nil

        params = convert_column_to_params( seed_item_hash )
        
        if is_valid?(params) then
          begin
            druid = register_object_using_web_service params
          rescue  Exception => e  
            puts e.message  
            puts e.backtrace.inspect  
            puts 'Error in registring the object'  
          end 
        else
          puts "Missing required parameters #{params}"
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
      
      def register_object_using_web_service params
        puts params
        response=RestClient.post Rails.configuration.service_root,  params, :timeout => 60, :open_timeout => 60
        code = response.code

        if code == 201 then
          druid = response.body
          return druid
        else
          raise "Error in registring the object"  
        end
      end
    end

  end
end