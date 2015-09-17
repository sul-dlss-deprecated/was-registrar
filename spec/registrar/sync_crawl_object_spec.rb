require 'spec_helper'

describe Was::Registrar::SyncCrawlObject do
  before :all do
    @staging_path = Pathname(File.dirname(__FILE__)).join('../fixtures/staging/')
  end

  describe '.sync_staging' do
    pending
  end

  describe '.sync_dor' do
    pending
  end
end
