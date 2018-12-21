# frozen_string_literal: true

namespace :was_registrar do

  desc 'Registering crawl objects listed in a file'
  task :register_crawls => :environment do
    puts 'Starting registering crawl task'
    input_file_path = ENV['INPUT'] # specify the input file that list all the crawls directory
    log_file_path =  ENV['LOG'] # specify the log file that will record the error
    puts input_file_path
    unless input_file_path.present? && log_file_path.present?
      puts 'INPUT or LOG parameters is missing'
      puts "Usage bundle exec rake was_registrar:register_crawls INPUT='crawl_list.txt' LOG='log/register_crawls.log'"
    else
      Was::Registrar::RegisterCrawlObjectFromFile.register(input_file_path, log_file_path)
    end
  end

end
