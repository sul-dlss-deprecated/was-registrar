require 'was/utilities/dor_utilities'
require 'was/registrar/sync_crawl_object'
require 'was/registrar/register_crawl_object'

class CrawlsController < ApplicationController
  layout 'application'
  respond_to :html, :json

  def index
    @crawls = CrawlItem.all
    @collections_list = []
    @apos_list = []

    apo_reader = Was::Utilities::DorUtilities.new(Rails.configuration.crawl_apos)
    apo_collection_list = apo_reader.get_collections_list

    apo_collection_list.each do |apo|
      @apos_list.push([apo[:apo_title], apo[:apo_druid]])
      apo[:apo_collection].each do |collection|
        @collections_list.push([collection[:title], collection[:druid]])
      end
    end
  end

  def do_action
    crawl_ids = params['crawls']
    action_type = params['action_list']

    case action_type
    when 'Register'
      register(crawl_ids)
    #   when 'Delete'
    #     delete( seed_ids)
    else
      #  Send Error message
    end
  end

  def register(crawl_ids)
    @crawl_list = []

    if crawl_ids.present?
      crawl_ids.each do |id|
        begin
          crawl_item = CrawlItem.find id
        rescue ActiveRecord::RecordNotFound => e
          crawl_item = CrawlItem.new(id: id)
        end

        @crawl_list.push(crawl_item)
      end
    end

    render(:register)
  end

  def register_one_item
    crawl_id = params['id']
    crawl_item =  CrawlItem.find crawl_id

    registrar = Was::Registrar::RegisterCrawlObject.new
    @register_status = {}

    begin
      druid = registrar.register crawl_item.serializable_hash
      crawl_item.update(druid_id: "#{druid}")
      @register_status['druid'] = crawl_item.druid_id
      @register_status['status'] = true
    rescue => e
      logger.fatal e.message
      @register_status['status'] = false
      @register_status['message'] = e.message
    end

    respond_with(@register_status)
  end

  def sync
    sync_service = Was::Registrar::SyncCrawlObject.new
    sync_service.sync_all
    redirect_to('/crawls/index')
  end

  def update_collection
    id = params['id']
    collection_id = params['collection_id'].sub('%3A', ':')
    update_database(id, :collection_id, collection_id)
  end

  def update_apo
    id = params['id']
    apo_id = params['apo_id'].sub('%3A', ':')
    update_database(id, :apo_id, apo_id)
  end

  def update_source_id
    id = params['id']
    source_id = params['source_id']
    update_database(id, :source_id, source_id)
  end

  def update_database(id, column_name, column_value)
    crawl_item = CrawlItem.find id
    crawl_item.update(column_name => column_value)
    render nothing: true, status: 200
  rescue => e
    logger.fatal e.message
    render nothing: true, status: 500
  end
end
