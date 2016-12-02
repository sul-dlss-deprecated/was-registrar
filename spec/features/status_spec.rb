require 'rails_helper'

describe 'application and dependency monitoring' do
  it '/status checks if Rails app is running' do
    visit '/status'
    expect(page.status_code).to eq 200
    expect(page).to have_text('Application is running')
  end
  it '/status/all checks if required dependencies are ok and also shows non-crucial dependencies' do
    visit '/status/all'
    expect(page).to have_text('PASSED')
    expect(page).to have_text('ruby_version')
    expect(page).to have_text('seed_staging_dir')
    expect(page).to have_text('OPTIONAL')
    expect(page).to have_text('external-dor_services_app') # non-crucial
    expect(page).to have_text('external-argo_status') # non-crucial
    expect(page).to have_text('external-default_seed_apo') # non-crucial
  end
end
