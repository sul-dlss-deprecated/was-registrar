# frozen_string_literal: true

require 'nokogiri'

module Was
  module Registrar
    # Writes the XML file that represents the seed object, this XML will be read later by wasSeedPreassemblyWF
    class SourceXmlWriter
      def initialize(location_path)
        @location_path = location_path
      end

      def write_xml seed_hash
        staging_xml = build_xml seed_hash

        staging_file_path = File.join(@location_path, seed_hash['druid_id'] + '.xml')
        f = File.open(staging_file_path, 'w');
        f.write(staging_xml);
        f.close
      end

      def build_xml(seed_hash)
        seed_hash['source']  = seed_hash['source'].nil?  ? 'AIT' : seed_hash['source']
        seed_hash['embargo'] = seed_hash['embargo'].nil? ? 'False' : seed_hash['embargo']

        staging_xml = Nokogiri::XML::Builder.new do
          item do
            druid_id      seed_hash['druid_id']
            collection_id seed_hash['collection_id']
            source_id     seed_hash['source_id']
            uri           seed_hash['uri']
            source        seed_hash['source']
            embargo       seed_hash['embargo']
          end
        end

        doc = Nokogiri::XML(staging_xml.to_xml)
        doc.root.last_element_child.after('<source_xml>' + seed_hash['source_xml'] + '</source_xml>')

        return doc.to_xml
      end
    end
  end
end
