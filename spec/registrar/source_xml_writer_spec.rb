require 'spec_helper'
 

describe Was::Registrar::RegisterSeedObject do

  before :all do
  end

  describe ".write_xml" do
  end

  describe ".build_xml" do
    
    it "should return valid xml for valid seed hash" do
      
      registrar = Was::Registrar::SourceXmlWriter.new("")
       seed_item = SeedItem.find 17
       staging_xml = registrar.build_xml( seed_item.serializable_hash )
       puts staging_xml
    end
    
  end
end