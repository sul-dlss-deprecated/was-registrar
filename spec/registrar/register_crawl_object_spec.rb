require 'spec_helper'
 

describe Was::Registrar::RegisterCrawlObject do

  before :all do
  end

  before :each do
  end


  describe ".register" do
 #   it "should register a crawl object" do
 #     registrar = Was::Registrar::RegisterCrawlObject.new
 #     crawl_item = CrawlItem.find 14
 #     puts crawl_item.serializable_hash
 #     registrar.register crawl_item.serializable_hash
 #   end
    
    it "shoud return a valid druid with valid params " do
      hash = {"source_id"=>"aaa", "collection_id"=>"druid:gz033bg3146","job_directory"=>"jobs/directory","rights"=>"world"}

      registrar = Was::Registrar::RegisterCrawlObject.new
      allow(registrar).to receive(:register_object_using_web_service) { "druid:aa111aa1111" }
      expect(registrar.register hash).to eq("druid:aa111aa1111") 
      
    end
    
    it "shoud raise an exception with an invalid params" do
      hash = {"source_id"=>"aaa", "collection_id"=>"druid:gz033bg3146","rights"=>"world"}

      registrar = Was::Registrar::RegisterCrawlObject.new
      allow(registrar).to receive(:register_object_using_web_service) { "druid:aa111aa1111" }
      expect{ registrar.register hash }.to raise_error
      
    end
  end
  
  describe ".is_valid?" do
    it "should return true if all the required fields appear" do
      params = {:object_type=>"item", :admin_policy=>"druid:gv121gk7467", :source_id=>"aaa", :label=>"job/directory", :collection=>"druid:gz033bg3146", :initiate_workflow=>"wasCrawlPreassemblyWF", :rights=>"dark"}
      registrar = Was::Registrar::RegisterCrawlObject.new

      expect(registrar.is_valid?(params)).to be true
      
    end
    
    it "should return false if source_id is missing" do
      params = {:object_type=>"item", :admin_policy=>"druid:gv121gk7467",  :label=>"job/directory", :collection=>"druid:gz033bg3146", :initiate_workflow=>"wasCrawlPreassemblyWF", :rights=>"dark"}
      registrar = Was::Registrar::RegisterCrawlObject.new

      expect(registrar.is_valid?(params)).to be false
    end
    it "should return false if source_id is nil" do
      params = {:object_type=>"item", :admin_policy=>"druid:gv121gk7467",  :source_id=>nil, :label=>"job/directory", :collection=>"druid:gz033bg3146", :initiate_workflow=>"wasCrawlPreassemblyWF", :rights=>"dark"}
      registrar = Was::Registrar::RegisterCrawlObject.new

      expect(registrar.is_valid?(params)).to be false
    end

   it "should return false if source_id is blank" do
      params = {:object_type=>"item", :admin_policy=>"druid:gv121gk7467",  :source_id=>"", :label=>"job/directory", :collection=>"druid:gz033bg3146", :initiate_workflow=>"wasCrawlPreassemblyWF", :rights=>"dark"}
      registrar = Was::Registrar::RegisterCrawlObject.new

      expect(registrar.is_valid?(params)).to be false
    end


    it "should return false if collection is missing" do
      params = {:object_type=>"item", :admin_policy=>"druid:gv121gk7467", :source_id=>"aaa", :label=>"job/directory",  :initiate_workflow=>"wasCrawlPreassemblyWF", :rights=>"dark"}
      registrar = Was::Registrar::RegisterCrawlObject.new

      expect(registrar.is_valid?(params)).to be false
    end
    it "should return false if collection is nil" do
      params = {:object_type=>"item", :admin_policy=>"druid:gv121gk7467",  :source_id=>"aaa", :label=>"job/directory", :collection=>nil, :initiate_workflow=>"wasCrawlPreassemblyWF", :rights=>"dark"}
      registrar = Was::Registrar::RegisterCrawlObject.new

      expect(registrar.is_valid?(params)).to be false
    end

   it "should return false if collection is blank" do
      params = {:object_type=>"item", :admin_policy=>"druid:gv121gk7467",  :source_id=>"aaa", :label=>"job/directory", :collection=>"", :initiate_workflow=>"wasCrawlPreassemblyWF", :rights=>"dark"}
      registrar = Was::Registrar::RegisterCrawlObject.new

      expect(registrar.is_valid?(params)).to be false
    end

   it "should return false if label is missing" do
      params = {:object_type=>"item", :admin_policy=>"druid:gv121gk7467",  :source_id=>"aaa",  :collection=>"druid:gz033bg3146", :initiate_workflow=>"wasCrawlPreassemblyWF", :rights=>"dark"}
      registrar = Was::Registrar::RegisterCrawlObject.new

      expect(registrar.is_valid?(params)).to be false
    end
    it "should return false if label is nil" do
      params = {:object_type=>"item", :admin_policy=>"druid:gv121gk7467",  :source_id=>"aaa",  :label=>nil, :collection=>"druid:gz033bg3146", :initiate_workflow=>"wasCrawlPreassemblyWF", :rights=>"dark"}
      registrar = Was::Registrar::RegisterCrawlObject.new

      expect(registrar.is_valid?(params)).to be false
    end

   it "should return false if label is blank" do
      params = {:object_type=>"item", :admin_policy=>"druid:gv121gk7467",  :source_id=>"aaa",  :label=>"", :collection=>"druid:gz033bg3146", :initiate_workflow=>"wasCrawlPreassemblyWF", :rights=>"dark"}
      registrar = Was::Registrar::RegisterCrawlObject.new

      expect(registrar.is_valid?(params)).to be false
    end

  end
  
  describe ".convert_column_to_params" do
    it "should convert hash to params" do
      
      registrar = Was::Registrar::RegisterCrawlObject.new
      hash = {"source_id"=>"aaa", "collection_id"=>"druid:gz033bg3146","job_directory"=>"jobs/directory","rights"=>"world"}
      params = registrar.convert_column_to_params hash
      expect(params[:source_id]).to eq("aaa")
      expect(params[:collection]).to eq("druid:gz033bg3146")
      expect(params[:label]).to eq("jobs/directory")
      expect(params[:initiate_workflow]).to eq("wasCrawlPreassemblyWF")
      expect(params[:rights]).to eq("dark")
      
    end
    
    it "should return nil for the missing fields " do
      registrar = Was::Registrar::RegisterCrawlObject.new
      hash = {"source_id"=>"aaa", "collection_id"=>"druid:gz033bg3146","rights"=>"world"}
      params = registrar.convert_column_to_params hash   
      
      expect(params[:source_id]).to eq("aaa")
      expect(params[:collection]).to eq("druid:gz033bg3146")
      expect(params[:label]).to be_nil
      expect(params[:initiate_workflow]).to eq("wasCrawlPreassemblyWF")
      expect(params[:rights]).to eq("dark") 
    end
    
    it "should not include unwanted fields" do
      
      registrar = Was::Registrar::RegisterCrawlObject.new
      hash = {"source_id"=>"aaa", "collection_id"=>"druid:gz033bg3146","job_directory"=>"jobs/directory","rights"=>"world","embargo"=>"true"}
      params = registrar.convert_column_to_params hash
      expect(params[:source_id]).to eq("aaa")
      expect(params[:collection]).to eq("druid:gz033bg3146")
      expect(params[:label]).to eq("jobs/directory")
      expect(params[:initiate_workflow]).to eq("wasCrawlPreassemblyWF")
      expect(params[:rights]).to eq("dark")
      expect(params[:embargo]).to be_nil
    end
    
  end
end
