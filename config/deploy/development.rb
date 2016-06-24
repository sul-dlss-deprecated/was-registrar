server 'was-registrar-dev.stanford.edu', user: 'was', roles: %w{web app db}

Capistrano::OneTimeKey.generate_one_time_key!

set :bundle_without, %w{deployment test}.join(' ')
set :deploy_environment, 'development'
