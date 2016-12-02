source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.7.1'
gem 'responders' # controller-level `respond_to' feature now in `responders` gem as of rails 4.2
gem 'mysql2', '~> 0.3.18'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'therubyracer',  platforms: :ruby
gem 'execjs'
gem 'config' # rails environment specific configs

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'

gem 'nokogiri'

gem 'rest-client'
gem 'okcomputer' # for 'upness' monitoring

group :development do
  gem 'sdoc', '~> 0.4.0'
  gem 'spring'
  gem 'yard'
end

group :test, :development do
  gem 'pry-byebug', require: false
  gem 'rubocop', require: false
  gem "sqlite3", :platform => [:ruby, :mswin, :mingw]
end

group :test do
  gem 'coveralls', require: false
  gem 'rspec-rails'
  gem 'capybara' # for feature/integration tests
  gem 'equivalent-xml' # for semantic comparison of xml
end

group :deployment do
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'
  gem 'capistrano-rails'
  gem 'dlss-capistrano'
end
