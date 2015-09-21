require 'spec_helper'
 

describe Was::Registrar::RegisterSeedObject do
  before :all do
    Rails.configuration.seed_apo = 'druid:xy123yz4567'
  end
  describe ".register" do
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
