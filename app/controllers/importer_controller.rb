# frozen_string_literal: true

require 'was/importer/data_importer_from_text' 
require 'was/importer/data_importer_results'

class ImporterController < ApplicationController
  
  layout 'application'

  def index
  end
  
  def upload
    metadata_source_ext = params[:metadata_source_ext]
    metadata_source = params[:metadata_source]
    seed_file_path = params[:seed_file]
    metadata_file_path = params[:metadata_file]
    
    unless seed_file_path.nil? then
      seed_file_text = seed_file_path.read
    else
      @message = 'seed file is required'
      return
    end
    
    if metadata_source != 'G' && metadata_file_path.nil?
      @message = 'metadata source xml file is required for non-Generic parser'
      return
    end
    
    metadata_file_text = nil
    if metadata_source != 'G' 
      metadata_file_text = metadata_file_path.read
    end
    
    if metadata_source != 'G' && metadata_source_ext.present?
      metadata_source = "#{metadata_source}_#{metadata_source_ext}"
    end
    data_importer = Was::Importer::DataImporterFromText.new(seed_file_text, metadata_source, metadata_file_text)
    @result_list = data_importer.load()
  end  
end
