require 'was/registrar/register_seed_object.rb' 
require 'was/registrar/source_xml_writer.rb' 

class AdminController < ApplicationController
  
  layout 'application'
  def index
    @seeds = SeedItem.all
  end

  def register
    puts "In register"
    @seed_list = []
    seed_ids =  params["seeds"]

    writer = Was::Registrar::SourceXmlWriter.new   Rails.configuration.staging_path
    
    unless seed_ids.nil? then 
      seed_ids.each do | id |
        
        seed_item =  SeedItem.find id
        @seed_list.push(seed_item)
        
        registrar = Was::Registrar::RegisterSeedObject.new  
        druid = registrar.register seed_item.serializable_hash
        
        unless druid.nil? then
          #update the seeditem with druid id
          #return theses results back
          seed_item.update(druid_id: "#{druid}")
          writer.write_xml_output seed_item.serializable_hash
        else
           
        end 
      end
    end
  end

  def update
    
  end
end
