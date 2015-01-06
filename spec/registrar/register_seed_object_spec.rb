require 'spec_helper'
 

describe Was::Registrar::RegisterSeedObject do

  describe ".register" do
 #   it "should register a seed object" do
 #     registrar = Was::Registrar::RegisterSeedObject.new
 #     hash = {"source_id"=>"aaa", "collection_id"=>"druid:gz033bg3146","uri"=>"http://www.slac.stanford.edu","rights"=>"world"}
 #     registrar.register hash
  #  end
    
    it "shoud return a valid druid with valid params " do
      hash = {"source_id"=>"aaa", "collection_id"=>"druid:gz033bg3146","uri"=>"http://www.slac.stanford.edu","rights"=>"world"}

      registrar = Was::Registrar::RegisterSeedObject.new
      allow(registrar).to receive(:register_object_using_web_service) { "druid:aa111aa1111" }
      expect(registrar.register hash).to eq("druid:aa111aa1111") 
    end
    
    it "shoud raise an exception with an invalid params" do
      hash = {"source_id"=>"aaa", "collection_id"=>nil,"uri"=>"http://www.slac.stanford.edu","rights"=>"world"}
      registrar = Was::Registrar::RegisterSeedObject.new
      allow(registrar).to receive(:register_object_using_web_service) { "druid:aa111aa1111" }
      expect{ registrar.register hash }.to raise_error
    end
  end

  describe ".is_valid" do
    it "should return true for valid argument" do
      params={:object_type=>"item", :admin_policy=>"druid:gv121gk7467", :source_id=>"aaa", :label=>"http://www.slac.stanford.edu", :collection=>"druid:gz033bg3146", :initiate_workflow=>"wasSeedPreassemblyWF", :rights=>"world"}      
      registrar = Was::Registrar::RegisterSeedObject.new

      expect(registrar.is_valid?(params)).to be true
    end
    
    it "should return false for missing source_id" do
      params={:object_type=>"item", :admin_policy=>"druid:gv121gk7467",  :label=>"http://www.slac.stanford.edu", :collection=>"druid:gz033bg3146", :initiate_workflow=>"wasSeedPreassemblyWF", :rights=>"world"}      
      registrar = Was::Registrar::RegisterSeedObject.new

      expect(registrar.is_valid?(params)).to be false
   
    end

    it "should return false for nil source_id" do
      params={:object_type=>"item", :admin_policy=>"druid:gv121gk7467", :source_id=>nil, :label=>"http://www.slac.stanford.edu", :collection=>"druid:gz033bg3146", :initiate_workflow=>"wasSeedPreassemblyWF", :rights=>"world"}      
      registrar = Was::Registrar::RegisterSeedObject.new

      expect(registrar.is_valid?(params)).to be false
    end

    it "should return false for blank source_id" do
      params={:object_type=>"item", :admin_policy=>"druid:gv121gk7467", :source_id=>"", :label=>"http://www.slac.stanford.edu", :collection=>"druid:gz033bg3146", :initiate_workflow=>"wasSeedPreassemblyWF", :rights=>"world"}      
      registrar = Was::Registrar::RegisterSeedObject.new

      expect(registrar.is_valid?(params)).to be false
    end

    it "should return false for missing collection" do
      params={:object_type=>"item", :admin_policy=>"druid:gv121gk7467", :source_id=>"aaa", :label=>"http://www.slac.stanford.edu", :initiate_workflow=>"wasSeedPreassemblyWF", :rights=>"world"}      
      registrar = Was::Registrar::RegisterSeedObject.new

      expect(registrar.is_valid?(params)).to be false
    end
    
    it "should return false for nil collection" do
        params={:object_type=>"item", :admin_policy=>"druid:gv121gk7467", :source_id=>"aaa", :label=>"http://www.slac.stanford.edu", :collection=>nil, :initiate_workflow=>"wasSeedPreassemblyWF", :rights=>"world"}      
      registrar = Was::Registrar::RegisterSeedObject.new

      expect(registrar.is_valid?(params)).to be false
    end
    
    it "should return false for blank collection" do
      params={:object_type=>"item", :admin_policy=>"druid:gv121gk7467", :source_id=>"aaa", :label=>"http://www.slac.stanford.edu", :collection=>"", :initiate_workflow=>"wasSeedPreassemblyWF", :rights=>"world"}      
      registrar = Was::Registrar::RegisterSeedObject.new

      expect(registrar.is_valid?(params)).to be false
   end

    it "should return false for missing label" do
      params={:object_type=>"item", :admin_policy=>"druid:gv121gk7467", :source_id=>"aaa",  :collection=>"druid:gz033bg3146", :initiate_workflow=>"wasSeedPreassemblyWF", :rights=>"world"}      
      registrar = Was::Registrar::RegisterSeedObject.new

      expect(registrar.is_valid?(params)).to be false
    end

     it "should return false for missing label" do
      params={:object_type=>"item", :admin_policy=>"druid:gv121gk7467", :source_id=>"aaa", :label=>nil, :collection=>"druid:gz033bg3146", :initiate_workflow=>"wasSeedPreassemblyWF", :rights=>"world"}      
      registrar = Was::Registrar::RegisterSeedObject.new

      expect(registrar.is_valid?(params)).to be false
    end

    it "should return false for missing label" do
      params={:object_type=>"item", :admin_policy=>"druid:gv121gk7467", :source_id=>"aaa", :label=>"", :collection=>"druid:gz033bg3146", :initiate_workflow=>"wasSeedPreassemblyWF", :rights=>"world"}      
      registrar = Was::Registrar::RegisterSeedObject.new

      expect(registrar.is_valid?(params)).to be false
    end

  end


  describe ".convert_column_to_params" do

    it "should convert hash to params" do
      registrar = Was::Registrar::RegisterSeedObject.new
      hash = {"source_id"=>"aaa", "collection_id"=>"druid:gz033bg3146","uri"=>"http://www.slac.stanford.edu","rights"=>"world"}

      params = registrar.convert_column_to_params hash
      expect(params[:source_id]).to eq("aaa")
      expect(params[:collection]).to eq("druid:gz033bg3146")
      expect(params[:label]).to eq("http://www.slac.stanford.edu")
      expect(params[:initiate_workflow]).to eq("wasSeedPreassemblyWF")
      expect(params[:rights]).to eq("world")
    end
    
    it "should return nil for the missing fields " do
      registrar = Was::Registrar::RegisterSeedObject.new
      hash = {"source_id"=>"aaa", "uri"=>"http://www.slac.stanford.edu","rights"=>"world"}

      params = registrar.convert_column_to_params hash
      expect(params[:source_id]).to eq("aaa")
      expect(params[:collection]).to be_nil
      expect(params[:label]).to eq("http://www.slac.stanford.edu")
      expect(params[:initiate_workflow]).to eq("wasSeedPreassemblyWF")
      expect(params[:rights]).to eq("world")
    end
    
    it "should not include unwanted fields" do
      registrar = Was::Registrar::RegisterSeedObject.new
      hash = {"source_id"=>"aaa", "uri"=>"http://www.slac.stanford.edu", "collection_id"=>"druid:gz033bg3146","rights"=>"world", "embargo"=>"true"}

      params = registrar.convert_column_to_params hash
      expect(params[:source_id]).to eq("aaa")
      expect(params[:collection]).to eq("druid:gz033bg3146")
      expect(params[:label]).to eq("http://www.slac.stanford.edu")
      expect(params[:initiate_workflow]).to eq("wasSeedPreassemblyWF")
      expect(params[:rights]).to eq("world")
      expect(params[:embargo]).to be_nil
    end
    
    it "should convert hash to params with uri only" do
      registrar = Was::Registrar::RegisterSeedObject.new
      hash = {"source_id"=>"aaa", "collection_id"=>"druid:gz033bg3146","uri"=>"http://www.slac.stanford.edu","rights"=>"world"}

      params = registrar.convert_column_to_params hash
      expect(params[:source_id]).to eq("aaa")
      expect(params[:collection]).to eq("druid:gz033bg3146")
      expect(params[:label]).to eq("http://www.slac.stanford.edu")
      expect(params[:initiate_workflow]).to eq("wasSeedPreassemblyWF")
      expect(params[:rights]).to eq("world")
    end
    
    it "should convert hash to params with title only" do
      registrar = Was::Registrar::RegisterSeedObject.new
      hash = {"source_id"=>"aaa", "collection_id"=>"druid:gz033bg3146","title"=>"test seed uri","rights"=>"world"}

      params = registrar.convert_column_to_params hash
      expect(params[:source_id]).to eq("aaa")
      expect(params[:collection]).to eq("druid:gz033bg3146")
      expect(params[:label]).to eq("test seed uri")
      expect(params[:initiate_workflow]).to eq("wasSeedPreassemblyWF")
      expect(params[:rights]).to eq("world")
    end
    
    it "should convert hash to params with nil label if neither title nor label appeared" do
      registrar = Was::Registrar::RegisterSeedObject.new
      hash = {"source_id"=>"aaa", "collection_id"=>"druid:gz033bg3146","rights"=>"world"}

      params = registrar.convert_column_to_params hash
      expect(params[:source_id]).to eq("aaa")
      expect(params[:collection]).to eq("druid:gz033bg3146")
      expect(params[:label]).to be_nil
      expect(params[:initiate_workflow]).to eq("wasSeedPreassemblyWF")
      expect(params[:rights]).to eq("world")
    end

  end

end