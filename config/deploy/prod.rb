# frozen_string_literal: true

set :bundle_without, %w{deployment development test}.join(' ')
set :deploy_environment, 'production'
set :rails_env, fetch(:deploy_environment)

server 'was-registrar-prod.stanford.edu', user: 'was', roles: %w(web db app)

Capistrano::OneTimeKey.generate_one_time_key!
