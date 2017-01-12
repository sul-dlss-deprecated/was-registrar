require 'rails_helper'

describe Was::Importer::DataImporterFromText do

  before :all do
    @epa_uri = "http://www.epa.gov/"
    collection_2361_metadata_file = "spec/fixtures/collectionFeed_2361.xml"
    @collection_xml = Nokogiri::XML(File.read(collection_2361_metadata_file))
  end

  before :each do
      @epa_xml = "<seed><url>http://www.epa.gov/</url><active>true</active><public>true</public><createdDate>2011-02-02 03:19:56 UTC</createdDate><lastUpdatedDate>2014-09-24 19:37:52 UTC</lastUpdatedDate><metadata><description>Web site of the US Environmental Protection Agency (EPA). Site contains information on environmental laws and regulations, as well as scientific research on environmental protection.</description><title>US Environmental Protection Agency</title><creator>United States. Environmental Protection Agency</creator><publisher>EPA</publisher><type>text</type><format>html</format><collector>Stanford University, Social Sciences Resource Group</collector><subject>Environmental policy--United States.</subject><subject>Environmental law--United States</subject><language>eng</language></metadata></seed><seed><url>http://www.gao.gov/</url><active>true</active><public>true</public><createdDate>2011-02-02 03:19:56 UTC</createdDate><lastUpdatedDate>2014-09-24 19:37:38 UTC</lastUpdatedDate><metadata><description>Web site of the U.S. Government Accountability Office (GAO). The GAO is an independent, nonpartisan agency that works for the U.S. Congress. GAO investigates how the federal government spends taxpayer dollars. It supports congressional oversight by auditing agency operations to determine whether federal funds are being spent efficiently and effectively, investigating allegations of illegal and improper activities,  reporting on how well government programs and policies are meeting their objectives, performing policy analyses and outlining options for congressional consideration, and issuing legal decisions and opinions, such as bid protest rulings and reports on agency rules.</description><title>U.S. Government Accountability Office (U.S. GAO)</title><creator>United States. Government Accountability Office</creator><publisher>GAO</publisher><type>text</type><format>html</format><collector>Stanford University, Social Sciences Resource Group</collector><subject>Government accountability--United States</subject><subject>Legislative auditing--United States</subject><subject>Finance, Public--United States--Accounting</subject><subject>Legislative oversight --United States</subject><language>eng</language></metadata></seed>"
  end

  describe ".load" do
    pending
  end

  describe ".extract_source_xml" do
    pending
  end
end
