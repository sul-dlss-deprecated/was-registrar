module Was
  module Importer
    class MetadataExtractor
      
      def self.extract_from_ait(source_metadata_xml_doc, seed_uri)
        if source_metadata_xml_doc.present? then     
          return source_metadata_xml_doc.xpath("//seed[url=\"#{seed_uri}\"]").to_s
        end
        return ''
      end

      def self.extract_from_cdl(source_metadata_xml_doc, seed_uri)
        if source_metadata_xml_doc.present? then
          xml_element = source_metadata_xml_doc.xpath("//xmlns:site[xmlns:uri=\"#{seed_uri}\"]")
          return xml_element.to_s unless xml_element.nil?
        end
        return ''
      end
    end
  end
end
