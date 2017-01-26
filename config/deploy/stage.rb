set :bundle_without, %w{deployment development test}.join(' ')
set :deploy_environment, 'production'
set :rails_env, fetch(:deploy_environment)
set :honeybadger_env, 'stage'
