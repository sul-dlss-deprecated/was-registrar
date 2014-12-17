require 'spec_helper'
 

describe Was::Registrar::RegisterCrawlObject do

  before :all do
  end

  before :each do
  end

  describe ".register" do
    it "should register a crawl object" do
      registrar = Was::Registrar::RegisterCrawlObject.new
      crawl_item = CrawlItem.find 14
      puts crawl_item.serializable_hash
      #hash = {"source_id"=>"aaa", "collection_id"=>"druid:gz033bg3146","uri"=>"http://www.slac.stanford.edu","rights"=>"world"}
      registrar.register crawl_item.serializable_hash

    end
  end
end
