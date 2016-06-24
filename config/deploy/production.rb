server 'was-registrar-prod.stanford.edu', user: 'was', roles: %w{web app db}

Capistrano::OneTimeKey.generate_one_time_key!

set :deploy_environment, 'production'
