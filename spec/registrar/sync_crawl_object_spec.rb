require 'spec_helper'
 

describe Was::Registrar::SyncCrawlObject do

  before :all do
    @staging_path = Pathname(File.dirname(__FILE__)).join("../fixtures/staging/")

  end

  before :each do
  end

  describe ".sync_staging" do
    
    it "should read staging directory in db" do
      
      sync_service = Was::Registrar::SyncCrawlObject.new
      Rails.configuration.crawl_stage = @staging_path
      sync_service.sync_staging
    end
    
  end
  
  describe ".sync_dor" do
    
    it "should read crawl_items from Dor and update druid id" do
      sync_service = Was::Registrar::SyncCrawlObject.new
      sync_service.sync_dor
 
    end
  end
  
end