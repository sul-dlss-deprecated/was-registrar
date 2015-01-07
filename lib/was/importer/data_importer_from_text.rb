require 'nokogiri'
require 'was/importer/data_importer'
require 'was/importer/data_importer_verifier'

module Was
  module Importer
      class DataImporterFromText < DataImporter

        def initialize(item_list_text, source_metadata_xml=nil, sep="\t")
          @item_list_text = item_list_text
          @sep = sep
          if source_metadata_xml.nil? or source_metadata_xml == '' then
            @source_metadata_xml_doc = nil
          else
            @source_metadata_xml_doc = Nokogiri::XML(source_metadata_xml)
          end
          
        end
    
        #Return SeedItemList
        def load
          
          data_importer_results = Was::Importer::DataImporterResults.new
          
          
          if @item_list_text.nil? or @item_list_text == "" then
            return null
          end
          fields_headers = []
          
          lines = @item_list_text.split("\n")
    
          lines.each_with_index do |line, index|
    
            if index == 0 then #It is the header line 
              fields_headers = line.split(@sep)
            else
              hash_record = fill_hash_record_from_line(SeedItem.column_names, fields_headers, line)
              
              source_metadata_xml_element = extract_source_xml(hash_record["uri"])
              
              hash_record['source_xml'] = source_metadata_xml_element.to_s
              
              status = Was::Importer::DataImporterVerifier.verify(hash_record)
              
              #Results reporting should be updated
              if status[0] then
                seed_item = SeedItem.new hash_record
                seed_item.save
                data_importer_results.add_succeeded_record
              else
                data_importer_results.add_failed_record status[0], status[1], line                 
              end
              
            end
          end
          return data_importer_results
        end
        
        # It will fill the hash_record with data from the input file that matches 
        # the column_names
        def fill_hash_record_from_line(column_names, headers, line)
          hash_record = Hash.new
          fields = line.split(@sep)
          
          fields.each_with_index do |field, field_id| 
            if column_names.include?( headers[field_id] ) then
              hash_record[headers[field_id]]  = field
            end
          end
          return hash_record
        end
      
        def extract_source_xml(uri)
          unless @source_metadata_xml_doc.nil? then     
            return @source_metadata_xml_doc.xpath("//seed[url=\"#{uri}\"]")
          end
          return ''
        end     
    end
  end
end