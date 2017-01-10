source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.7.1'
gem 'responders' # controller-level `respond_to' feature now in `responders` gem as of rails 4.2
gem "sqlite3", :platform => [:ruby, :mswin, :mingw]
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

group :development do
  gem 'sdoc', '~> 0.4.0'
  gem 'spring'
  gem 'yard'
end

group :test, :development do
  gem 'rubocop', require: false
  gem 'pry-byebug', require: false
end

group :test do
  gem 'coveralls', require: false
  gem 'equivalent-xml'
  gem "rspec"
  gem 'rspec-rails'
end

group :deployment do
  gem 'capistrano'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'
  gem 'capistrano-rails'
  gem 'dlss-capistrano'
end
