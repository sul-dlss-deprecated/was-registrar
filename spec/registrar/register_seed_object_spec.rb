require 'spec_helper'
 

describe Was::Registrar::RegisterSeedObject do

  before :all do
  end

  before :each do
  end

  describe ".register" do
  end

  describe ".is_valid" do
    it "should return true for valid argument" do
      
    end
    
    it "should return false for missing source_id" do
      
    end

    it "should return false for missing collection_id" do
      
    end


    it "should return false for missing title and uri" do
      
    end


    it "should return true for missing title but existent uri" do
      
    end

    it "should return true for missing uri but existent title" do
      
    end

  end

  describe ".convert_column_to_params" do
  end

  describe ".register_object_using_web_service" do
    
    it "should register object with valid params" do
        params=      {
            :object_type  => 'item', #It needs an update to Dor.registered_classes
            :admin_policy => Rails.configuration.apo,
            :source_id    => "was:registrar:test",
            :label        => "registrar_test",
            :collection   => "druid:gz033bg3146",
            :initiate_workflow => "wasSeedPreassemblyWF",
          }
          
        registrar = Was::Registrar::RegisterSeedObject.new
        druid = registrar.register_object_using_web_service params
        puts druid
        expect(druid).not_to be_nil    
          
    end
    
  end
  after :each do
  end
  
end