set :bundle_without, %w{deployment test}.join(' ')
set :deploy_environment, 'development'
set :rails_env, fetch(:deploy_environment)

server 'was-registrar-dev.stanford.edu', user: 'was', roles: %w(web db app)

Capistrano::OneTimeKey.generate_one_time_key!
