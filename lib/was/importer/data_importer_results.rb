# frozen_string_literal: true

module Was
  module Importer
    class DataImporterResults
      attr_reader :number_of_succeeded_records
      attr_reader :number_of_failed_records
      attr_reader :result_message_list

      def initialize
        @number_of_succeeded_records = 0
        @number_of_failed_records = 0
        @result_message_list = []
      end

      def add_succeeded_record
        @number_of_succeeded_records += 1
      end

      def add_failed_record(status, message, record)
        @number_of_failed_records += 1
        @result_message_list.push(status: status, message: message, record: record)
      end
    end
  end
end
