# frozen_string_literal: true

require 'time'

module CrawlsHelper
  def format_job_directory(job_directory)
    job_directory = job_directory[1..-1] if job_directory.start_with?('/')
    job_directory = job_directory[0..-2] if job_directory.end_with?('/')

    directory_fields = job_directory.split(/\//)
    if directory_fields.length == 2
      job_name = directory_fields[0].sub('_', ' ').sub('-', ' ').camelize
      job_date = directory_fields[1]

      begin
        job_date_object = DateTime.strptime(job_date, '%Y%m%e%H%M%S')
        job_date = job_date_object.strftime('%b %e, %Y %H:%M:%S')
      rescue StandardError
        nil
      end
      job_directory = "#{job_name} [#{job_date}]"
    end

    job_directory
  end
end
