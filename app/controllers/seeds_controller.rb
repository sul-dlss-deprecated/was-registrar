require 'was/registrar/register_seed_object'
require 'was/registrar/source_xml_writer'

class SeedsController < ApplicationController

  layout 'application'
  respond_to :html, :json

  def index
    @seeds = SeedItem.all
  end

  def do_action
    seed_ids =  params["seeds"]
    action_type = params['action_list']

    case action_type
    when 'Register'
      register(seed_ids)
    when 'Delete'
      delete(seed_ids)
    else
    # Returns Error message
    end
  end

  def register(seed_ids)
    @seed_list = []

    if seed_ids.present?
      seed_ids.each do | id |

        begin
          seed_item = SeedItem.find(id)
        rescue ActiveRecord::RecordNotFound => e
          seed_item = SeedItem.new(id:id)
        end

        @seed_list.push(seed_item)
      end
    end

    render(:register)
  end

  def register_one_item
    writer = Was::Registrar::SourceXmlWriter.new(Rails.configuration.staging_path)

    seed_id = params["id"]
    seed_item = SeedItem.find(seed_id)

    registrar = Was::Registrar::RegisterSeedObject.new
    @register_status = {}

    begin
      druid = registrar.register seed_item.serializable_hash
      seed_item.update(druid_id: "#{druid}")
      writer.write_xml seed_item.serializable_hash
      @register_status['druid']= seed_item.druid_id
      @register_status['status'] = true
    rescue => e
      logger.fatal e.inspect
      logger.fatal e.backtrace.join("\n") unless e.backtrace.nil?
      @register_status['status'] = false
      @register_status['message'] = e.message
    end

    respond_with(@register_status)
  end

  def update
  end

  def delete seed_ids

     @delete_status_list = []

    if seed_ids.present?
      seed_ids.each do | id |
        delete_status = {}

        begin
          seed_item =  SeedItem.find id
          delete_status['uri'] = seed_item.uri

          seed_item.delete

          delete_status['status'] = true
        rescue => e
          logger.fatal e.message
          delete_status['status'] = false
          delete_status['message'] = e.message
        end

        @delete_status_list.push(delete_status)
      end
    end

    render(:delete)
  end
end
