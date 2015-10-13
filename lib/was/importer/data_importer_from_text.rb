require 'nokogiri'
require 'was/importer/data_importer'
require 'was/importer/data_importer_verifier'

module Was
  module Importer
    class DataImporterFromText < DataImporter
      def initialize(item_list_text, metadata_source, source_metadata_xml = nil, sep = "\t")
        @item_list_text = item_list_text
        @sep = sep

        if source_metadata_xml.nil? || source_metadata_xml == ''
          @source_metadata_xml_doc = nil
        else
          @source_metadata_xml_doc = Nokogiri::XML(source_metadata_xml)
        end
        @metadata_source = metadata_source
      end

      def load_from_seed_list
        fields_headers = []
        hash_records = []
        lines = @item_list_text.split("\n")

        lines.each_with_index do |line, index|
          if index == 0 # It is the header line
            fields_headers = line.split(@sep)
          else
            hash_record = fill_hash_record_from_line(SeedItem.column_names, fields_headers, line)
            hash_records.append(hash_record)
          end
        end
        hash_records
      end

      def extract_from_xml(hash_records)
        hash_records.each do |hash_record|
          if @metadata_source.start_with?('AIT')
            source_metadata_xml = Was::Importer::MetadataExtractor.extract_from_ait(@source_metadata_xml_doc, hash_record['uri'])
            hash_record['source_xml'] = source_metadata_xml
          elsif @metadata_source.start_with?('CDL')
            source_metadata_xml = Was::Importer::MetadataExtractor.extract_from_cdl(@source_metadata_xml_doc, hash_record['uri'])
            hash_record['source_xml'] = source_metadata_xml
          else
            hash_record['source_xml'] = ''
          end
          hash_record['source'] = @metadata_source
        end
        hash_records
      end

      def insert_into_database(hash_records)
        data_importer_results = Was::Importer::DataImporterResults.new
        hash_records.each do |hash_record|
          status = Was::Importer::DataImporterVerifier.verify(hash_record)
          # Results reporting should be updated
          if status[0]
            seed_item = SeedItem.new(hash_record)
            seed_item.save
            data_importer_results.add_succeeded_record
          else
            data_importer_results.add_failed_record status[0], status[1], line
          end
        end
        data_importer_results
      end

      def load
        return null if @item_list_text.nil? || @item_list_text == ''

        hash_records = load_from_seed_list
        hash_records = extract_from_xml(hash_records)
        data_importer_results = insert_into_database(hash_records)
        data_importer_results
      end

      # It will fill the hash_record with data from the input file that matches
      # the column_names
      def fill_hash_record_from_line(column_names, headers, line)
        hash_record = {}
        fields = line.split(@sep)

        fields.each_with_index do |field, field_id|
          if column_names.include?(headers[field_id])
            hash_record[headers[field_id]] = field
          end
        end

        hash_record
      end
    end
  end
end
