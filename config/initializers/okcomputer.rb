# frozen_string_literal: true

require 'okcomputer'

# /status for 'upness', e.g. for load balancer
# /status/all to show all dependencies
# /status/<name-of-check> for a specific check (e.g. for nagios warning)
OkComputer.mount_at = 'status'
OkComputer.check_in_parallel = true

# REQUIRED checks, required to pass for /status/all
#  individual checks also avail at /status/<name-of-check>

OkComputer::Registry.register 'ruby_version', OkComputer::RubyVersionCheck.new
OkComputer::Registry.register 'seed_staging_dir', OkComputer::DirectoryCheck.new(Settings.seed_staging_path)

# ------------------------------------------------------------------------------

# NON-CRUCIAL (Optional) checks, avail at /status/<name-of-check>
#   - at individual endpoint, HTTP response code reflects the actual result
#   - in /status/all, these checks will display their result text, but will not affect HTTP response code

# We need DOR for actually registering druids, but when it is down we can still upload seeds to database
dor_svcs_about_url = "#{Settings.dor_services_url}/about"
OkComputer::Registry.register 'external-dor_services_app', OkComputer::HttpCheck.new(dor_svcs_about_url)

# We only use argo url for hotlinks to objects in views
argo_status_url = "#{Settings.argo_view_url.split('.edu').first}.edu/status"
OkComputer::Registry.register 'external-argo_status', OkComputer::HttpCheck.new(argo_status_url)

# only use seed_apo if data for seed being registered doesn't have an apo_id value (from uploaded .tsv file)
default_seed_apo_argo_url = "#{Settings.argo_view_url}#{Settings.seed_apo}"
OkComputer::Registry.register 'external-default_seed_apo', OkComputer::HttpCheck.new(default_seed_apo_argo_url)

OkComputer.make_optional %w[external-dor_services_app external-argo_status external-default_seed_apo]
