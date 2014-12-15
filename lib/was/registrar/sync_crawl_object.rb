module Was
  module Registrar
    class SyncCrawlObject 

      def sync_all
        sync_staging
        sync_dor
      end
      
      def sync_staging
        
        get_jobs_directories.each do | job_dir |
          crawl_item = CrawlItem.find_by job_directory: job_dir
          
          if crawl_item.nil? then
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
          short_job_dir_list.append( absoulte_job_dir.sub(jobs_directory,"") )
        end
        
        return short_job_dir_list
      end
      
      
      def sync_dor
        items_list = Was::Utilities::DorUtilities.get_items_list

        items_list.each do |item|
          crawl_item = CrawlItem.find_by job_directory: item[:title]
          puts item[:title]
          unless crawl_item.nil?
            crawl_item.update(:druid => item[:druid])
          end
           
        end    
      end

    end
  end
end
