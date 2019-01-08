# frozen_string_literal: true

module Was
  module Importer
    class DataImporterVerifier
      def self.verify(hash_record) 
        if  hash_record.has_key?('uri').present? &&
            hash_record.has_key?('source_id').present?  && 
            hash_record.has_key?('collection_id').present?
            then
          return [true,'OK']
        end

          return [false, 'Missing one of the required fields: uri, source_id, or collection_id']
      end
    end
  end
end