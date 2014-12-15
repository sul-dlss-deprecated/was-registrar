module Was
  module Utilities
    class DorUtilities
      def initalize
      end
        
      def self.get_collections_list
        begin
          response=RestClient.get("#{Rails.configuration.apo_list_call}#{Rails.configuration.apo}",  :timeout => 60, :open_timeout => 60)
          rescue Exception=> e
            puts "Error in registring the object. "+e.message 
            return []
          end
          collection_list= response.body
          collections_list=[]
          data = JSON.parse(collection_list)
          collection_json = data['collections']
          collection_json.each do | collection|
            collections_list.push({:title=>collection['title'], :druid=>collection['druid']})
          end
          return collections_list
          
          
      end
          
      def self.get_items_list
        begin
          response=RestClient.get("#{Rails.configuration.apo_list_call}#{Rails.configuration.apo}",  :timeout => 60, :open_timeout => 60)
          rescue Exception=> e
            puts "Error in registring the object. "+e.message 
            return []
          end
          items_list=[]
          data = JSON.parse(response.body)
          items_json = data['items']
          items_json.each do | item|
            items_list.push({:title=>item['title'], :druid=>item['druid']})
          end
          return items_list
      end
         
      
      
    end
  end
end
