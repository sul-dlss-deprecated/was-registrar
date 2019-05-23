# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Was::Registrar::RegisterCrawlObjectFromFile do
  describe '#verify_file' do
    let(:instance) { described_class.new(file, nil) }
    subject(:verify_file) { instance.send(:verify_file) }

    context 'when file is well-formatted with one line' do
      let(:file) { "#{fixture_path}/register_crawl_files/valid_one_line.txt" }
      it { is_expected.to be true }
    end

    context 'when file is well-formatted with multiple lines' do
      let(:file) { "#{fixture_path}/register_crawl_files/valid_multi_lines.txt" }
      it { is_expected.to be true }
    end

    context 'when file is not well-formatted with one line' do
      let(:file) { "#{fixture_path}/register_crawl_files/not_valid_one_line.txt" }
      it 'prints out errors' do
        expected_text = "Problem in line 2: \"WAS:Test\tjob1/warc\tdruid:ab123cd4567a\tdruid:mn123pq4567\""
        expect(STDOUT).to receive(:puts).with(expected_text)
        expect(verify_file).to be false
      end
    end

    context 'when file is not well-formatted with multiple lines' do
      let(:file) { "#{fixture_path}/register_crawl_files/not_valid_multi_lines.txt" }
      it 'prints out errors' do
        expected_text = "Problem in line 2: \"WAS:Test\tjob1/warc\tdruid:ab123cd4567a\tdruid:mn123pq4567\""
        expect(STDOUT).to receive(:puts).with(expected_text)
        expect(STDOUT).to receive(:puts).with("Problem in line 3: \"WAS:Test\t\tdruid:ef123gh4567\tdruid:mn123pq4567\"")
        expect(verify_file).to be false
      end
    end
  end

  describe '.register' do
    let(:workflow_client) { instance_double(Dor::Workflow::Client, create_workflow_by_name: nil) }
    before do
      allow(Dor::Workflow::Client).to receive(:new).and_return(workflow_client)
    end

    after do
      # This avoids: #<InstanceDouble(Dor::Workflow::Client) (anonymous)> was
      # originally created in one example but has leaked into another example
      described_class.instance_variable_set(:@workflow_client, nil)
    end

    context 'when the crawl list file one line' do
      it 'registers one item' do
        valid_file = "#{fixture_path}/register_crawl_files/valid_one_line.txt"
        allow_any_instance_of(Was::Registrar::RegisterCrawlObjectFromFile).to receive(:verify_file).and_return(true)
        exp_param_hash = {
          'source_id' => 'WAS:Test',
          'job_directory' => 'job1/warc',
          'collection_id' => 'druid:ab123cd4567',
          'apo_id' => 'druid:mn123pq4567'
        }
        expect_any_instance_of(Was::Registrar::RegisterCrawlObject).to receive(:register).with(exp_param_hash).and_return('druid:ab123cd4567')
        expect(STDOUT).to receive(:puts).with('Registering job1/warc with druid:ab123cd4567')
        expect(STDOUT).to receive(:puts).with("\nRegistering crawl objects:\nSuccess: 1\nFail: 0")
        Was::Registrar::RegisterCrawlObjectFromFile.register(valid_file, 'log/tmp.txt')
        expect(workflow_client).to have_received(:create_workflow_by_name).with(String, 'wasCrawlPreassemblyWF')
      end
    end

    context 'when the crawl list file has multiple lines' do
      it 'registers all items' do
        valid_file = "#{fixture_path}/register_crawl_files/valid_multi_lines.txt"
        allow_any_instance_of(Was::Registrar::RegisterCrawlObjectFromFile).to receive(:verify_file).and_return(true)
        exp_param_hash = {
          'source_id' => 'WAS:Test',
          'job_directory' => 'job1/warc',
          'collection_id' => 'druid:ab123cd4567',
          'apo_id' => 'druid:mn123pq4567'
        }
        expect_any_instance_of(Was::Registrar::RegisterCrawlObject).to receive(:register).once.with(exp_param_hash).and_return('druid:xy123yz4567')
        exp_param_hash = {
          'source_id' => 'WAS:Test',
          'job_directory' => 'job2/warc',
          'collection_id' => 'druid:ef123gh4567',
          'apo_id' => 'druid:mn123pq4567'
        }
        expect_any_instance_of(Was::Registrar::RegisterCrawlObject).to receive(:register).once.with(exp_param_hash).and_return('druid:mn123pq4567')
        expect(STDOUT).to receive(:puts).with('Registering job1/warc with druid:xy123yz4567')
        expect(STDOUT).to receive(:puts).with('Registering job2/warc with druid:mn123pq4567')
        expect(STDOUT).to receive(:puts).with("\nRegistering crawl objects:\nSuccess: 2\nFail: 0")
        Was::Registrar::RegisterCrawlObjectFromFile.register(valid_file, 'log/tmp.txt')
        expect(workflow_client).to have_received(:create_workflow_by_name).with(String, 'wasCrawlPreassemblyWF').twice
      end
    end

    it 'does not call RegisterCrawlObject.register if verify_file returns false' do
      allow_any_instance_of(Was::Registrar::RegisterCrawlObjectFromFile).to receive(:verify_file).and_return(false)
      expect_any_instance_of(Was::Registrar::RegisterCrawlObject).not_to receive(:register)
      Was::Registrar::RegisterCrawlObjectFromFile.register('', nil)
    end

    it 'logs an exception that is raised' do
      valid_file = "#{fixture_path}/register_crawl_files/valid_one_line.txt"
      allow_any_instance_of(Was::Registrar::RegisterCrawlObjectFromFile).to receive(:verify_file).and_return(true)
      allow_any_instance_of(Was::Registrar::RegisterCrawlObjectFromFile).to receive(:convert_line_to_hash).and_return(nil)
      expect_any_instance_of(Logger).to receive(:fatal).with(/Error registering/)
      expected_regex = /was-registrar\/lib\/was\/registrar\/register_crawl_object.rb:/
      expect_any_instance_of(Logger).to receive(:fatal).with(expected_regex)
      Was::Registrar::RegisterCrawlObjectFromFile.register(valid_file, 'tmp/log_from_spec.txt')
    end
  end
end
