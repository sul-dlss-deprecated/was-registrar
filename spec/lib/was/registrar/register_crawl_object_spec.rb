# frozen_string_literal: true

require 'rails_helper'

describe Was::Registrar::RegisterCrawlObject do
  describe '.register' do
    it 'shoud return a valid druid with valid params ' do
      hash = { 'source_id' => 'aaa', 'collection_id' => 'druid:gz033bg3146', 'job_directory' => 'jobs/directory', 'rights' => 'world', 'apo_id' => 'druid:ab123cd4567' }

      registrar = Was::Registrar::RegisterCrawlObject.new
      allow(registrar).to receive(:register_object_using_web_service).and_return('druid:aa111aa1111')
      expect(registrar.register(hash)).to eq('druid:aa111aa1111')
    end

    it 'shoud raise an exception with an invalid params' do
      hash = { 'source_id' => 'aaa', 'collection_id' => 'druid:gz033bg3146', 'rights' => 'world' }
      registrar = Was::Registrar::RegisterCrawlObject.new
      allow(registrar).to receive(:register_object_using_web_service).and_return('druid:aa111aa1111')
      expect { registrar.register hash }.to raise_error('Missing required parameters {:object_type=>"item", :admin_policy=>nil, :source_id=>"aaa", :label=>nil, :collection=>"druid:gz033bg3146", :rights=>"dark"}')
    end
  end

  describe '.convert_column_to_params' do
    it 'should convert hash to params' do
      registrar = Was::Registrar::RegisterCrawlObject.new
      hash = { 'source_id' => 'aaa', 'collection_id' => 'druid:gz033bg3146', 'job_directory' => 'jobs/directory', 'rights' => 'world' }
      params = registrar.convert_column_to_params hash

      expect(params[:source_id]).to eq('aaa')
      expect(params[:collection]).to eq('druid:gz033bg3146')
      expect(params[:label]).to eq('jobs/directory')
      expect(params[:rights]).to eq('dark')
    end

    it 'should return nil for the missing fields ' do
      registrar = Was::Registrar::RegisterCrawlObject.new
      hash = { 'source_id' => 'aaa', 'collection_id' => 'druid:gz033bg3146', 'rights' => 'world' }
      params = registrar.convert_column_to_params hash

      expect(params[:source_id]).to eq('aaa')
      expect(params[:collection]).to eq('druid:gz033bg3146')
      expect(params[:label]).to be_nil
      expect(params[:rights]).to eq('dark')
    end

    it 'should not include unwanted fields' do
      registrar = Was::Registrar::RegisterCrawlObject.new
      hash = { 'source_id' => 'aaa', 'collection_id' => 'druid:gz033bg3146', 'job_directory' => 'jobs/directory', 'rights' => 'world', 'embargo' => 'true' }
      params = registrar.convert_column_to_params hash

      expect(params[:source_id]).to eq('aaa')
      expect(params[:collection]).to eq('druid:gz033bg3146')
      expect(params[:label]).to eq('jobs/directory')
      expect(params[:rights]).to eq('dark')
      expect(params[:embargo]).to be_nil
    end
  end
end
