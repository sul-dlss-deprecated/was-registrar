class CrawlRegistrarController < ApplicationController
  def index
    jobs_directory = "#{Rails.configuration.crawl_stage}"
    @jobs_list = Dir.glob('#{jobs_directory}*/*/') # {|f| File.directory? f} 
    @collections_list = get_collections_list
   # respond_with({:jobs=>@jobs_list, :collections=>@collections_list})
  end


  def register( )
      @seed_list = []
      
      unless seed_ids.nil? then 
        seed_ids.each do | id |
          begin
            seed_item =  SeedItem.find id
          rescue ActiveRecord::RecordNotFound => e
            seed_item =  SeedItem.new(id:id)
          end
          @seed_list.push(seed_item)
        end
      end
      render(register)
  end
  
  def register_one_item(label, collection_id)
    sleep(5)
    writer = Was::Registrar::SourceXmlWriter.new   Rails.configuration.staging_path

    registrar = Was::Registrar::RegisterCrawlObject.new  
    @register_status = {}
    
    begin
      druid = registrar.register label, collection_id
      writer.write_xml seed_item.serializable_hash
      @register_status['druid']= seed_item.druid_id
      @register_status['status'] = true
    
    rescue Exception => e
      @register_status['status'] = false
      @register_status['message'] = e.message  
    end
    respond_with(@register_status)
  end
  
  def get_collections_list
    begin
      response=RestClient.get("#{Rails.configuration.collection_list_call}#{Rails.configuration.apo}",  :timeout => 60, :open_timeout => 60)
      rescue Exception=> e
        puts "Error in registring the object. "+e.message 
        return ""
      end
      puts response.body
      collection_list= response.body
      collections_list=[]
      data = JSON.parse(collection_list)
      collection_json = data['collections']
      collection_json.each do | collection|
        result = [collection['title'],collection['druid']]
        collections_list.push(result)
      end
      return collections_list
      
  end
end
