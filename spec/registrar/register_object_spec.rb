require 'spec_helper'

describe Was::Registrar::RegisterSeedObject do

  describe '.register_object_using_web_service' do
    it 'should register object with valid params' do
      Rails.configuration.service_root = 'https://registr.stanford.edu/'
      params = {
        object_type: 'item',
        admin_policy: 'druid:ab123cd4567',
        source_id: 'was:baa',
        label: 'registrar_test',
        collection: 'druid:kg698nv1738',
        initiate_workflow: 'wasSeedPreassemblyWF',
        rights: 'world'
      }
      response = double('net http response', to_hash: { 'Status' => ['200 OK'] }, code: 200, body: 'druid:aa111aa1111')

      registrar = Was::Registrar::RegisterObject.new
      expect_any_instance_of(RestClient::Resource).to receive(:post).with(params, accept: :text).and_return(response)
      expect(registrar.register_object_using_web_service(params)).to eq('druid:aa111aa1111')
    end
    it 'should raise an error if the response is not valid druid' do
      params = {}
      response = double('net http response', to_hash: { 'Status' => ['200 OK'] }, code: 200, body: 'not_valid_druid')
      registrar = Was::Registrar::RegisterObject.new
      expect_any_instance_of(RestClient::Resource).to receive(:post).with(params, accept: :text).and_return(response)
      expect { registrar.register_object_using_web_service(params) }.to raise_error(RuntimeError, /Error in registering the object/)
    end
    it 'should raise an error if the client connection fails' do
      params = {}
      expect_any_instance_of(RestClient::Resource).to receive(:post).with(params, accept: :text).and_raise(RestClient::Exception)
      registrar = Was::Registrar::RegisterObject.new
      expect_any_instance_of(Logger).to receive(:error).once
      expect { registrar.register_object_using_web_service(params) }.to raise_error(RestClient::Exception)
    end
    it 'should raise an error on an unexpected exception' do
      params = {}
      expect_any_instance_of(RestClient::Resource).to receive(:post).with(params, accept: :text).and_raise(RuntimeError)
      registrar = Was::Registrar::RegisterObject.new
      expect_any_instance_of(Logger).not_to receive(:error)
      expect { registrar.register_object_using_web_service(params) }.to raise_error(RuntimeError)
    end
  end

  describe '.is_valid?' do
    it 'should return true if all the required fields appear' do
      params = { object_type: 'item', admin_policy: 'druid:gv121gk7467', source_id: 'aaa', label: 'job/directory', collection: 'druid:gz033bg3146', initiate_workflow: 'wasCrawlPreassemblyWF', rights: 'dark' }
      registrar = Was::Registrar::RegisterObject.new

      expect(registrar.is_valid?(params)).to be true
    end

    it 'should return false if source_id is missing' do
      params = { object_type: 'item', admin_policy: 'druid:gv121gk7467',  label: 'job/directory', collection: 'druid:gz033bg3146', initiate_workflow: 'wasCrawlPreassemblyWF', rights: 'dark' }
      registrar = Was::Registrar::RegisterObject.new

      expect(registrar.is_valid?(params)).to be false
    end
    it 'should return false if source_id is nil' do
      params = { object_type: 'item', admin_policy: 'druid:gv121gk7467',  source_id: nil, label: 'job/directory', collection: 'druid:gz033bg3146', initiate_workflow: 'wasCrawlPreassemblyWF', rights: 'dark' }
      registrar = Was::Registrar::RegisterObject.new

      expect(registrar.is_valid?(params)).to be false
    end

    it 'should return false if source_id is blank'  do
      params = { object_type: 'item', admin_policy: 'druid:gv121gk7467',  source_id: '', label: 'job/directory', collection: 'druid:gz033bg3146', initiate_workflow: 'wasCrawlPreassemblyWF', rights: 'dark ' }
      registrar = Was::Registrar::RegisterObject.new

      expect(registrar.is_valid?(params)).to be false
    end

    it 'should return false if collection is missing' do
      params = { object_type: 'item', admin_policy: 'druid:gv121gk7467', source_id: 'aaa', label: 'job/directory',  initiate_workflow: 'wasCrawlPreassemblyWF', rights: 'dark' }
      registrar = Was::Registrar::RegisterObject.new

      expect(registrar.is_valid?(params)).to be false
    end
    it 'should return false if collection is nil' do
      params = { object_type: 'item', admin_policy: 'druid:gv121gk7467',  source_id: 'aaa', label: 'job/directory', collection: nil, initiate_workflow: 'wasCrawlPreassemblyWF', rights: 'dark' }
      registrar = Was::Registrar::RegisterObject.new

      expect(registrar.is_valid?(params)).to be false
    end

    it 'should return false if collection is blank'  do
      params = { object_type: 'item', admin_policy: 'druid:gv121gk7467',  source_id: 'aaa', label: 'job/directory', collection: '', initiate_workflow: 'wasCrawlPreassemblyWF', rights: 'dark ' }
      registrar = Was::Registrar::RegisterObject.new

      expect(registrar.is_valid?(params)).to be false
    end

    it 'should return false if label is missing'  do
      params = { object_type: 'item', admin_policy: 'druid:gv121gk7467',  source_id: 'aaa',  collection: 'druid:gz033bg3146', initiate_workflow: 'wasCrawlPreassemblyWF', rights: 'dark ' }
      registrar = Was::Registrar::RegisterObject.new

      expect(registrar.is_valid?(params)).to be false
    end
    it 'should return false if label is nil' do
      params = { object_type: 'item', admin_policy: 'druid:gv121gk7467',  source_id: 'aaa',  label: nil, collection: 'druid:gz033bg3146', initiate_workflow: 'wasCrawlPreassemblyWF', rights: 'dark' }
      registrar = Was::Registrar::RegisterObject.new

      expect(registrar.is_valid?(params)).to be false
    end

    it 'should return false if label is blank'  do
      params = { object_type: 'item', admin_policy: 'druid:gv121gk7467',  source_id: 'aaa',  label: '', collection: 'druid:gz033bg3146', initiate_workflow: 'wasCrawlPreassemblyWF', rights: 'dark ' }
      registrar = Was::Registrar::RegisterObject.new

      expect(registrar.is_valid?(params)).to be false
    end
  end
end
