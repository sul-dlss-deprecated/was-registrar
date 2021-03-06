# frozen_string_literal: true

set :application, 'was-registrar'
set :repo_url, 'https://github.com/sul-dlss/was-registrar.git'

# Default branch is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/opt/app/was/was-registrar'

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :info

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w[config/database.yml config/honeybadger.yml config/secrets.yml]

# Default value for linked_dirs is []
set :linked_dirs, %w[config/settings data log public/system tmp/cache vendor/bundle]

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# update shared_configs before restarting app
before 'deploy:restart', 'shared_configs:update'

# honeybadger_env otherwise defaults to rails_env
# we want prod rather than production
set :honeybadger_env, fetch(:stage)
