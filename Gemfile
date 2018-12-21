# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rails', '~> 5.0'
gem 'responders' # controller-level `respond_to' feature now in `responders` gem as of rails 4.2
gem 'mysql2'
gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'config' # rails environment specific configs

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'

gem 'nokogiri'

gem 'okcomputer' # for 'upness' monitoring
gem 'honeybadger' # for exception reporting

# Stanford Gems
gem 'dor-services-client'

group :development do
  gem 'sdoc', '~> 0.4.0'
  gem 'spring'
  gem 'listen'
end

group :test, :development do
  gem 'pry-byebug', require: false
  gem 'rubocop', require: false
  gem 'sqlite3', :platform => %i[ruby mswin mingw]
end

group :test do
  gem 'coveralls', require: false
  gem 'rspec-rails'
  gem 'capybara' # for feature/integration tests
  gem 'equivalent-xml' # for semantic comparison of xml
  gem 'rails-controller-testing'
end

group :deployment do
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'
  gem 'capistrano-rails'
  gem 'dlss-capistrano'
end
