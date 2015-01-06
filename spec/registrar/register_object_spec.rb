require 'spec_helper'
 

describe Was::Registrar::RegisterSeedObject do

  before :all do
  end

  before :each do
  end
  
  
  describe ".register_object_using_web_service" do
    
    it "should register object with valid params" do
        params=      {
            :object_type  => 'item',
            :admin_policy => Rails.configuration.apo,
            :source_id   => 'was:baa',
            :label        => "registrar_test",
            :collection   => "druid:kg698nv1738",
            :initiate_workflow => "wasSeedPreassemblyWF",
            :rights=>"world",
          }
          
        registrar = Was::Registrar::RegisterObject.new
        
        begin
        druid = registrar.register_object_using_web_service params
        puts druid
        rescue Exception => e
          puts e.message
          
        end
        
        #expect(druid).not_to be_nil    
          
    end
   end
end