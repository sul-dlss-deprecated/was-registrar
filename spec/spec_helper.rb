require_relative '../lib/was/importer/data_importer'
require_relative '../lib/was/importer/data_importer_from_text'
require_relative '../lib/was/importer/data_importer_verifier'
require_relative '../lib/was/registrar/register_seed_object'
require_relative '../lib/was/registrar/source_xml_writer'
require_relative '../lib/was/registrar/sync_crawl_object'
require_relative '../lib/was/utilities/dor_utilities'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'development'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
