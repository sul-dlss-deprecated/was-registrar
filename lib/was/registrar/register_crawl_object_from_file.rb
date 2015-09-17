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
        return unless verify_file(input_file_path)

        logger = Logger.new(log_file)
        success_count = 0
        fail_count = 0
        registrar = Was::Registrar::RegisterCrawlObject.new

        input_file = File.open(input_file_path)
        input_file.each_with_index do |line, index|
          next if index == 0
          register_hash = convert_line_to_hash line
          begin
            druid = registrar.register register_hash
            puts "Registering #{register_hash['job_directory']} with #{druid}"
            success_count += 1
          rescue => e
            puts "Error in registering #{line} with #{e.inspect}"
            logger.fatal "Error in registering #{line} with #{e.inspect}"
            fail_count += 1
          end
        end
        puts "\nRegistering crawl objects:\nSuccess: #{success_count}\nFail: #{fail_count}"
        input_file.close
      end

      def self.convert_line_to_hash(line)
        fields = line.strip.split("\t")
        source_id = fields[0]
        job_directory = fields[1]
        collection_id = fields[2]
        apo_id = fields[3]
        
        return { 'source_id' => source_id, 'job_directory' => job_directory, 'collection_id' => collection_id, 'apo_id' => apo_id }
      end

      def self.verify_file(input_file_path)
        status = true

        input_file = File.open(input_file_path)
        input_file.each_with_index do |line, index|
          next if index == 0
          if (line.strip =~ pattern).nil?
            status = false
            puts "Problem in line #{line.strip}"
          end
        end
        input_file.close
        return status
      end

      def self.pattern
        /\A[\S]+\t\S+\tdruid:([a-z]{2})(\d{3})([a-z]{2})(\d{4})\tdruid:([a-z]{2})(\d{3})([a-z]{2})(\d{4})\z/
      end
    end
  end
end
