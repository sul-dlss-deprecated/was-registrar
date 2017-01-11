set :bundle_without, %w{deployment test}.join(' ')
set :deploy_environment, 'development'
set :rails_env, fetch(:deploy_environment)
