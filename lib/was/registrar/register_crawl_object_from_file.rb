# frozen_string_literal: true

# workaround for https://github.com/sul-dlss/dor-workflow-client/issues/109
require 'dor/workflow/client/version'

module Was
  module Registrar
    # Registers a set of crawl objects defined by an input file
    class RegisterCrawlObjectFromFile
      # Registers the items in the input_file_path and log the errors in log_file
      # @example file format:
      #   Source_id job_directory collection_id
      #   WAS:Test  jobs1/warc    druid:ab123cd4567
      # @param input_file_path [String] the path to the crawl object list
      # @param log_file [String] the path to the log file
      def self.register(input_file_path, log_file)
        new(input_file_path, log_file).register
      end

      def initialize(input_file_path, log_file)
        @input_file_path = input_file_path
        @logger = Logger.new(log_file)
      end

      def register
        return unless verify_file

        success_count = 0
        fail_count = 0
        registrar = Was::Registrar::RegisterCrawlObject.new

        input_file = File.open(input_file_path)
        input_file.each_with_index do |line, index|
          next if index.zero?

          begin
            register_one_line(line, registrar)
            success_count += 1
          rescue StandardError => e
            msg = "Error registering line #{index + 1}: \"#{line}\" with #{e.inspect}"
            puts msg
            puts e.backtrace.join("\n") unless e.backtrace.nil?
            logger.fatal msg
            logger.fatal e.backtrace.join("\n") unless e.backtrace.nil?
            Honeybadger.notify(e)
            fail_count += 1
          end
        end
        puts "\nRegistering crawl objects:\nSuccess: #{success_count}\nFail: #{fail_count}"
        input_file.close
      end

      private

      attr_reader :input_file_path, :logger

      def register_one_line(line, registrar)
        register_hash = convert_line_to_hash line
        druid = registrar.register register_hash

        workflow_client.create_workflow_by_name(druid, 'wasCrawlPreassemblyWF')
        puts "Registering #{register_hash['job_directory']} with #{druid}"
        logger.info "Registering #{register_hash['job_directory']} with #{druid}"
      end

      def workflow_client
        @workflow_client ||= Dor::Workflow::Client.new(url: Settings.workflow.url)
      end

      def convert_line_to_hash(line)
        fields = line.strip.split("\t")
        source_id = fields[0]
        job_directory = fields[1]
        collection_id = fields[2]
        apo_id = fields[3]

        { 'source_id' => source_id, 'job_directory' => job_directory, 'collection_id' => collection_id, 'apo_id' => apo_id }
      end

      def verify_file
        status = true

        input_file = File.open(input_file_path)
        input_file.each_with_index do |line, index|
          next if index.zero?

          if (line.strip =~ pattern).nil?
            status = false
            puts "Problem in line #{index + 1}: \"#{line.strip}\""
          end
        end
        input_file.close
        status
      end

      # @return [Regex] the regular expression for a druid
      def pattern
        /\A[\S]+\t\S+\tdruid:([a-z]{2})(\d{3})([a-z]{2})(\d{4})\tdruid:([a-z]{2})(\d{3})([a-z]{2})(\d{4})\z/
      end
    end
  end
end
