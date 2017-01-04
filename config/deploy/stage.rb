server 'was-registrar-stage.stanford.edu', user: 'was', roles: %w{web app db}

Capistrano::OneTimeKey.generate_one_time_key!

set :bundle_without, %w{deployment development test}.join(' ')
set :deploy_environment, 'production'
set :rails_env, fetch(:deploy_environment)