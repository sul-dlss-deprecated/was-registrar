require 'coveralls'
Coveralls.wear!

require_relative '../lib/was/importer/data_importer'
require_relative '../lib/was/importer/data_importer_results'
require_relative '../lib/was/importer/data_importer_from_text'
require_relative '../lib/was/importer/data_importer_verifier'

require_relative '../lib/was/registrar/register_seed_object'
require_relative '../lib/was/registrar/register_crawl_object'
require_relative '../lib/was/registrar/register_crawl_object_from_file'
require_relative '../lib/was/registrar/source_xml_writer'
require_relative '../lib/was/registrar/sync_crawl_object'

require_relative '../lib/was/utilities/dor_utilities'

require 'rspec/matchers'
require 'equivalent-xml'
require 'nokogiri'


# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'development'
require File.expand_path("../../config/environment", __FILE__)
