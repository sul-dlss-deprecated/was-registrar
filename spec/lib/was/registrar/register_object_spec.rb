require 'rails_helper'

describe Was::Registrar::RegisterSeedObject do
  describe '#register_object_using_web_service' do

    it 'registers object with valid params' do
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

      expect_any_instance_of(Faraday::Connection).to receive(:post).and_return(response)

      registrar = Was::Registrar::RegisterObject.new
      expect(registrar.register_object_using_web_service(params)).to eq('druid:aa111aa1111')
    end

    it 'raises an error if the response is not valid druid' do
      params = {}
      response = double('net http response', to_hash: { 'Status' => ['200 OK'] }, code: 200, body: 'not_valid_druid')

      expect_any_instance_of(Faraday::Connection).to receive(:post).and_return(response)

      registrar = Was::Registrar::RegisterObject.new
      exp_regex = /Error in registering the object/
      expect { registrar.register_object_using_web_service(params) }.to raise_error(RuntimeError, exp_regex)
     end
  end

  describe '#is_valid?' do
    let(:params) do
      {
        object_type: 'item',
        admin_policy: 'druid:gv121gk7467',
        source_id: 'aaa',
        label: 'job/directory',
        collection: 'druid:gz033bg3146',
        initiate_workflow: 'wasCrawlPreassemblyWF',
        rights: 'dark'
      }
    end

    it 'true if all the required fields appear' do
      registrar = Was::Registrar::RegisterObject.new
      expect(registrar.is_valid?(params)).to be true
    end

    it 'false if source_id is missing' do
      params.delete(:source_id)
      registrar = Was::Registrar::RegisterObject.new
      expect(registrar.is_valid?(params)).to be false
    end

    it 'false if source_id is nil' do
      params[:source_id] = nil
      registrar = Was::Registrar::RegisterObject.new
      expect(registrar.is_valid?(params)).to be false
    end

    it 'false if source_id is blank'  do
      params[:source_id] = ''
      registrar = Was::Registrar::RegisterObject.new
      expect(registrar.is_valid?(params)).to be false
    end

    it 'false if collection is missing' do
      params.delete(:collection)
      registrar = Was::Registrar::RegisterObject.new
      expect(registrar.is_valid?(params)).to be false
    end

    it 'false if collection is nil' do
      params[:collection] = nil
      registrar = Was::Registrar::RegisterObject.new
      expect(registrar.is_valid?(params)).to be false
    end

    it 'false if collection is blank'  do
      params[:collection] = ''
      registrar = Was::Registrar::RegisterObject.new
      expect(registrar.is_valid?(params)).to be false
    end

    it 'false if label is missing'  do
      params.delete(:label)
      registrar = Was::Registrar::RegisterObject.new
      expect(registrar.is_valid?(params)).to be false
    end

    it 'false if label is nil' do
      params[:label] = nil
      registrar = Was::Registrar::RegisterObject.new
      expect(registrar.is_valid?(params)).to be false
    end

    it 'false if label is blank'  do
      params[:label] = ''
      registrar = Was::Registrar::RegisterObject.new
      expect(registrar.is_valid?(params)).to be false
    end
  end
end
