# frozen_string_literal: true

require 'rails_helper'

describe Was::Registrar::RegisterSeedObject do
  before :all do
    @fixtures = 'spec/fixtures/'
    @source_xml = '<?xml version="1.0"?> <item>   <druid_id>druid:aa111aa1111</druid_id>   <collection_id>druid:gz033bg3146</collection_id>   <source_id>was:a</source_id>   <uri>http://www.slac.stanford.edu/</uri>   <source>AIT</source>   <embargo>false</embargo><source_xml><seed>   <url>http://www.slac.stanford.edu/</url>   <active>true</active>   <public>true</public>   <createdDate>2013-01-27 21:34:12 UTC</createdDate>   <lastUpdatedDate>2014-09-24 19:37:17 UTC</lastUpdatedDate>   <metadata>     <title>United States Global Change Research Program</title>     <creator>U.S. Global Change Research Program</creator>     <publisher>U.S. Global Change Research Program</publisher>     <collector>Stanford University, Social Sciences Resource Group</collector>     <type>text</type>     <format>html</format>     <subject>Climatic changes--Research--United States</subject>     <subject>Global environmental change--Research--United States</subject>     <description>Web site of the United States Global Change Research Program. The USGCRP coordinates and integrates federal research on climate change and changes in the global environment, as well as their implication for society.</description>     <language>eng</language>   </metadata> </seed></source_xml> </item>'
  end

  describe '.write_xml' do
    it 'should write a valid xml file' do
      registrar = Was::Registrar::SourceXmlWriter.new('./')
      seed_hash = { 'id' => 23,
                    'druid_id' => 'druid:aa111aa1111',
                    'uri' => 'http://www.slac.stanford.edu/',
                    'embargo' => false,
                    'source' => nil,
                    'collection_id' => 'druid:gz033bg3146',
                    'source_xml' => "<seed>\n  <url>http://www.slac.stanford.edu/</url>\n  <active>true</active>\n  <public>true</public>\n
                      <createdDate>2013-01-27 21:34:12 UTC</createdDate>\n  <lastUpdatedDate>2014-09-24 19:37:17 UTC</lastUpdatedDate>\n
                      <metadata>\n    <title>United States Global Change Research Program</title>\n    <creator>U.S. Global Change Research
                      Program</creator>\n    <publisher>U.S. Global Change Research Program</publisher>\n    <collector>Stanford University,
                      Social Sciences Resource Group</collector>\n    <type>text</type>\n    <format>html</format>\n    <subject>Climatic
                      changes--Research--United States</subject>\n    <subject>Global environmental change--Research--United States</subject>\n
                      <description>Web site of the United States Global Change Research Program. The USGCRP coordinates and integrates federal
                      research on climate change and changes in the global environment, as well as their implication for society.</description>\n
                      <language>eng</language>\n  </metadata>\n</seed>",
                    'source_file' => nil,
                    'import_date' => nil,
                    'created_at' => 'Tue, 09 Dec 2014 18:55:54 UTC +00:00',
                    'updated_at' => 'Thu, 11 Dec 2014 15:47:47 UTC +00:00',
                    'verified' => nil,
                    'source_id' => 'was:a',
                    'rights' => 'world' }
      registrar.write_xml(seed_hash)

      actual_xml_file_path = './druid:aa111aa1111.xml'
      expected_xml_file_path = "#{@fixtures}druid:aa111aa1111.xml"

      expect(File.read(actual_xml_file_path).to_s).to be_equivalent_to(File.read(expected_xml_file_path).to_s)
    end
  end

  describe '.build_xml' do
    it 'should return valid xml for valid seed hash' do
      registrar = Was::Registrar::SourceXmlWriter.new('')

      seed_hash = { 'id' => 23,
                    'druid_id' => 'druid:aa111aa1111',
                    'uri' => 'http://www.slac.stanford.edu/',
                    'embargo' => false,
                    'source' => nil,
                    'collection_id' => 'druid:gz033bg3146',
                    'source_xml' => "<seed>\n  <url>http://www.slac.stanford.edu/</url>\n  <active>true</active>\n  <public>true</public>\n  <createdDate>2013-01-27 21:34:12 UTC</createdDate>\n  <lastUpdatedDate>2014-09-24 19:37:17 UTC</lastUpdatedDate>\n  <metadata>\n    <title>United States Global Change Research Program</title>\n    <creator>U.S. Global Change Research Program</creator>\n    <publisher>U.S. Global Change Research Program</publisher>\n    <collector>Stanford University, Social Sciences Resource Group</collector>\n    <type>text</type>\n    <format>html</format>\n    <subject>Climatic changes--Research--United States</subject>\n    <subject>Global environmental change--Research--United States</subject>\n    <description>Web site of the United States Global Change Research Program. The USGCRP coordinates and integrates federal research on climate change and changes in the global environment, as well as their implication for society.</description>\n    <language>eng</language>\n  </metadata>\n</seed>",
                    'source_file' => nil,
                    'import_date' => nil,
                    'created_at' => 'Tue, 09 Dec 2014 18:55:54 UTC +00:00',
                    'updated_at' => 'Thu, 11 Dec 2014 15:47:47 UTC +00:00',
                    'verified' => nil,
                    'source_id' => 'was:a',
                    'rights' => 'world' }
      staging_xml = registrar.build_xml(seed_hash)
      expect(staging_xml).to be_equivalent_to(@source_xml)
    end
  end

  after :all do
    FileUtils.rm('./druid:aa111aa1111.xml') if File.exist?('./druid:aa111aa1111.xml')
  end
end
