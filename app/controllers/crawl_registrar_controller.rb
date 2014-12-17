require 'was/utilities/dor_utilities.rb' 
require 'was/registrar/sync_crawl_object.rb' 
require 'was/registrar/register_crawl_object.rb' 

class CrawlRegistrarController < ApplicationController
 
  layout 'application'   
  respond_to :html, :json


  def index
    @crawls=CrawlItem.all
    
    collections_list_hash = Was::Utilities::DorUtilities.get_collections_list
    
   # @collections_list = [["aaa","aaa"],["bbb","bbb"]]
   @collections_list=[]
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

  def register( crawl_ids)
    
      @crawl_list = []
      puts crawl_ids
      
      unless crawl_ids.nil? then 
        crawl_ids.each do | id |
          begin
            crawl_item =  CrawlItem.find id
          rescue ActiveRecord::RecordNotFound => e
            crawl_item =  CrawlItem.new(id:id)
          end
          @crawl_list.push(crawl_item)
        end
      end
      render(:register)
  end
  
  def register_one_item 

    crawl_id = params["id"]
    crawl_item =  CrawlItem.find crawl_id
         
    registrar = Was::Registrar::RegisterCrawlObject.new  
    @register_status = {}
    
    begin
      druid = registrar.register crawl_item.serializable_hash
      crawl_item.update(druid_id: "#{druid}")
      @register_status['druid']= crawl_item.druid_id
      @register_status['status'] = true
    
    rescue Exception => e
      puts e
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

  def update_collection
    id = params['id']
    collection_id = params['collection_id'].sub("%3A",":")
    
    begin
      crawl_item = CrawlItem.find id
      crawl_item.update(:collection_id=> collection_id)
      @status=true
    rescue
      @status=false
    end
    
  end
  def update_source_id
    id = params['id']
    source_id = params['source_id']
    
    begin
      crawl_item = CrawlItem.find id
      crawl_item.update(:source_id=> source_id)
      @status=true
    rescue
      @status=false
    end
  end



end
