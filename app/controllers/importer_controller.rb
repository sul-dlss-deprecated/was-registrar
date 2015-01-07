require 'was/importer/data_importer_from_text' 
require 'was/importer/data_importer_results'

class ImporterController < ApplicationController
  
  layout 'application'

  def index
  end
  
  def upload
    seed_file_path = params[:seed_file] 
    metadata_file_path = params[:metadata_file] 
    
    seed_file_text = seed_file_path.read
    metadata_file_text = metadata_file_path.read

    data_importer = Was::Importer::DataImporterFromText.new(seed_file_text, metadata_file_text)
    @result_list = data_importer.load()
  end  
end
