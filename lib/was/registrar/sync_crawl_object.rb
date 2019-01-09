# frozen_string_literal: true

module Was
  module Registrar
    # Synchronizes between the available crawl jobs, database, and DOR repo.
    # @deprecated - was possibly used when crawls were registered via crawls_controller
    class SyncCrawlObject
      def sync_all
        sync_staging
        sync_dor
      end

      # Reads the job directories from the staging mount
      def sync_staging
        get_jobs_directories.each do |job_dir|
          crawl_item = CrawlItem.find_by job_directory: job_dir

          if crawl_item.nil?
            CrawlItem.create({:job_directory=>job_dir, :on_disk=> true })
          else
            crawl_item.update(:on_disk=>true)
          end
        end
      end

      def get_jobs_directories
        jobs_directory = "#{Settings.crawl_jobs_path}"
        absolute_job_dir_list = Dir.glob("#{jobs_directory}*/2*/") # {|f| File.directory? f}

        short_job_dir_list = []
        absolute_job_dir_list.each do |absolute_job_dir|
          short_job_dir_list.append( absolute_job_dir.sub(jobs_directory, '')[0..-2] )
        end

        return short_job_dir_list
      end

      # Reads the crawl objects from DOR
      def sync_dor
        items_list = Was::Utilities::DorUtilities.new(Settings.crawl_apos).get_items_list

        items_list.each do |item|
          crawl_item = CrawlItem.find_by job_directory: item[:title]
          crawl_item&.update(:druid_id => item[:druid])
        end
      end
    end
  end
end
