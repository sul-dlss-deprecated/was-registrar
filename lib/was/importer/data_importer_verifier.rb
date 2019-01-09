# frozen_string_literal: true

module Was
  module Importer
    class DataImporterVerifier
      def self.verify(hash_record)
        if  hash_record.key?('uri').present? &&
            hash_record.key?('source_id').present? &&
            hash_record.key?('collection_id').present?
          return [true, 'OK']
        end

        [false, 'Missing one of the required fields: uri, source_id, or collection_id']
      end
    end
  end
end
