require 'spec_helper'

describe Was::Registrar::RegisterCrawlObjectFromFile do
  before :all do
    @fixtures = 'spec/fixtures/'
  end

  describe '.verify_file' do
    it 'returns true if the file is well-formatted with one line' do
      valid_file = "#{@fixtures}register_crawl_files/valid_one_line.txt"
      expect(Was::Registrar::RegisterCrawlObjectFromFile.verify_file(valid_file)).to be_truthy
    end
    it 'returns true if the file is well-formatted with multi lines' do
      valid_file = "#{@fixtures}register_crawl_files/valid_multi_lines.txt"
      expect(Was::Registrar::RegisterCrawlObjectFromFile.verify_file(valid_file)).to be_truthy
    end
    it 'returns false and print error message if the file is bad-formatted with one line' do
      not_valid_file = "#{@fixtures}register_crawl_files/not_valid_one_line.txt"
      expect(STDOUT).to receive(:puts).with("Problem in line WAS:Test\tjob1/warc\tdruid:ab123cd4567a\tdruid:mn123pq4567")

      expect(Was::Registrar::RegisterCrawlObjectFromFile.verify_file(not_valid_file)).to be_falsey
    end
    it 'returns false and print error message if the file is bad-formatted with multi lines' do
      not_valid_file = "#{@fixtures}register_crawl_files/not_valid_multi_lines.txt"
      expect(STDOUT).to receive(:puts).with("Problem in line WAS:Test\tjob1/warc\tdruid:ab123cd4567a\tdruid:mn123pq4567")
      expect(STDOUT).to receive(:puts).with("Problem in line WAS:Test\t\tdruid:ef123gh4567\tdruid:mn123pq4567")

      expect(Was::Registrar::RegisterCrawlObjectFromFile.verify_file(not_valid_file)).to be_falsey
    end
  end

  describe '.register' do
    it 'register one item in the crawl list file with one item' do
      valid_file = "#{@fixtures}register_crawl_files/valid_one_line.txt"
      allow(Was::Registrar::RegisterCrawlObjectFromFile).to receive(:verify_file).and_return(true)
      expect_any_instance_of(Was::Registrar::RegisterCrawlObject).to receive(:register).with('source_id' => 'WAS:Test', 'job_directory' => 'job1/warc', 'collection_id' => 'druid:ab123cd4567', 'apo_id' => 'druid:mn123pq4567').and_return('druid:ab123cd4567')
      expect(STDOUT).to receive(:puts).with('Registering job1/warc with druid:ab123cd4567')
      expect(STDOUT).to receive(:puts).with("\nRegistering crawl objects:\nSuccess: 1\nFail: 0")
      Was::Registrar::RegisterCrawlObjectFromFile.register(valid_file, 'log/tmp.txt')
    end
    it 'registers items in the crawl list file with multiple lines' do
      valid_file = "#{@fixtures}register_crawl_files/valid_multi_lines.txt"
      allow(Was::Registrar::RegisterCrawlObjectFromFile).to receive(:verify_file).and_return(true)
      expect_any_instance_of(Was::Registrar::RegisterCrawlObject).to receive(:register).once.with('source_id' => 'WAS:Test', 'job_directory' => 'job1/warc', 'collection_id' => 'druid:ab123cd4567', 'apo_id' => 'druid:mn123pq4567').and_return('druid:xy123yz4567')
      expect_any_instance_of(Was::Registrar::RegisterCrawlObject).to receive(:register).once.with('source_id' => 'WAS:Test', 'job_directory' => 'job2/warc', 'collection_id' => 'druid:ef123gh4567', 'apo_id' => 'druid:mn123pq4567').and_return('druid:mn123pq4567')
      expect(STDOUT).to receive(:puts).with('Registering job1/warc with druid:xy123yz4567')
      expect(STDOUT).to receive(:puts).with('Registering job2/warc with druid:mn123pq4567')
      expect(STDOUT).to receive(:puts).with("\nRegistering crawl objects:\nSuccess: 2\nFail: 0")
      Was::Registrar::RegisterCrawlObjectFromFile.register(valid_file, 'log/tmp.txt')
    end
    it 'does not call the registerar if there is any wrong records' do
      allow(Was::Registrar::RegisterCrawlObjectFromFile).to receive(:verify_file).and_return(false)
      expect_any_instance_of(Was::Registrar::RegisterCrawlObject).not_to receive(:register)
      Was::Registrar::RegisterCrawlObjectFromFile.register('', '')
    end
    it 'raises an exception that should be logged in the log file' do
      valid_file = "#{@fixtures}register_crawl_files/valid_one_line.txt"
      allow(Was::Registrar::RegisterCrawlObjectFromFile).to receive(:verify_file).and_return(true)
      expect(Was::Registrar::RegisterCrawlObjectFromFile).to receive(:convert_line_to_hash).and_return(nil)
      expect_any_instance_of(Logger).to receive(:fatal).with(/Error in registering/)
      expect_any_instance_of(Logger).to receive(:fatal).with(/was-registrar\/lib\/was\/registrar\/register_crawl_object.rb:/) # stack trace
      Was::Registrar::RegisterCrawlObjectFromFile.register(valid_file, 'log/tmp.txt')
    end
  end
end
