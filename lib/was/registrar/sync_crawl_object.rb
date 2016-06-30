module Was
  module Registrar

    # makes syncronization between the available crawl jobs, database, and DOR repo.
    class SyncCrawlObject

      def sync_all
        sync_staging
        sync_dor
      end

      # Reads the job directories from the staging mount
      def sync_staging

        get_jobs_directories.each do | job_dir |
          crawl_item = CrawlItem.find_by job_directory: job_dir

          if crawl_item.nil?
            CrawlItem.create({:job_directory=>job_dir, :on_disk=> true })
          else
            crawl_item.update(:on_disk=>true)
          end
        end
      end

      def get_jobs_directories
        jobs_directory = "#{Rails.configuration.crawl_stage}"
        absoulte_job_dir_list = Dir.glob("#{jobs_directory}*/2*/") # {|f| File.directory? f}

        short_job_dir_list = []
        absoulte_job_dir_list.each do | absoulte_job_dir |
          short_job_dir_list.append( absoulte_job_dir.sub(jobs_directory,"")[0..-2] )
        end

        return short_job_dir_list
      end

      # Reads the crawl objects from DOR
      #
      # TODO: We removed the implementation of this code since it was using
      # the REST interface to `dor-fetcher`, which is being phased out, to
      # fetch all items associated with the crawl APOs
      def sync_dor
        items_list = []
        fail NotImplementedError, 'Need to fetch all items associated with all the Crawl APOs'

        items_list.each do |item|
          crawl_item = CrawlItem.find_by job_directory: item[:title]
          unless crawl_item.nil?
            crawl_item.update(:druid_id => item[:druid])
          end
        end
      end

    end
  end
end
