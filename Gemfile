# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rails', '~> 5.2.2'

gem 'coffee-rails'
gem 'config' # rails environment specific configs
gem 'honeybadger' # for exception reporting
gem 'jbuilder', '~> 2.0'
gem 'jquery-rails'
gem 'mysql2'
gem 'nokogiri'
gem 'okcomputer' # for 'upness' monitoring
gem 'responders' # controller-level `respond_to' feature now in `responders` gem as of rails 4.2
gem 'sass-rails'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'

# Stanford Gems
gem 'dor-services-client', '~> 1.1'

group :development do
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'dlss-capistrano'
  gem 'listen'
  gem 'sdoc', '~> 0.4.0'
  gem 'spring'
end

group :test, :development do
  gem 'pry-byebug', require: false
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'sqlite3', '~> 1.3.13'
end

group :test do
  gem 'capybara' # for feature/integration tests
  gem 'coveralls', require: false
  gem 'equivalent-xml' # for semantic comparison of xml
  gem 'rails-controller-testing'
  gem 'rspec-rails'
end
