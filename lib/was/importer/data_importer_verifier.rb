module Was
  module Importer
    class DataImporterVerifier
      def self.verify(hash_record)
        
        #Missing required fields
        unless  hash_record.has_key?("uri") and hash_record["uri"].length > 0  and
                hash_record.has_key?("source_id")  and hash_record["source_id"].length > 0 and
                hash_record.has_key?("collection_id") and hash_record["collection_id"].length > 0
            then
          return [false, "Missing one of the required fields: uri, source_id, or collection_id"]
        end
        
        return [true,"OK"]
      end
    end
  end
end