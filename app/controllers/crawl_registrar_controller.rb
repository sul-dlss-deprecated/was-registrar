require 'was/utilities/dor_utilities.rb' 
require 'was/registrar/sync_crawl_object.rb' 

class CrawlRegistrarController < ApplicationController
 
  layout 'application'

  def index
    @crawls=CrawlItem.all
    
    collections_list_hash = Was::Utilities::DorUtilities.get_collections_list
    
    @collections_list = []
    collections_list_hash.each do | collection|
        result = [collection[:title],collection[:druid]]
        @collections_list.push(result)
    end
  end
  
  def do_action
    crawl_ids =  params["crawls"]
    action_type = params['action_list']
    
    case action_type
    when 'Register'
      puts crawl_ids
      register( crawl_ids)
 #   when 'Delete'
 #     puts seed_ids
 #     delete( seed_ids)
    else
      puts 'error'
    end
    
  end

  def register crawl_ids
    
      @crawl_list = []
      
      unless crawl_ids.nil? then 
        crawl_ids.each do | id |
          begin
            crawl_item =  CrawlItem.find id
          rescue ActiveRecord::RecordNotFound => e
            crawl_item =  CrawlItem.new(id:id)
          end
          @crawl_list.push(CrawlItem)
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
  

  def sync
    sync_service = Was::Registrar::SyncCrawlObject.new
    sync_service.sync_all
    redirect_to("/crawl_registrar/index")
  end
end
