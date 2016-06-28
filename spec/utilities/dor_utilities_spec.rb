require 'spec_helper'

describe Was::Utilities::DorUtilities do
  let(:druid) { 'druid:aa111aa1111' }
  subject { described_class.new(druid) }
  context '#read_apo_data' do
    it 'throws an error when reading APO data fails unexpectedly' do
      expect(RestClient).to receive(:get).and_raise(RestClient::Exception)
      expect(Rails.logger).to receive(:fatal).with(/Error in reading apo list/)
      expect(subject.get_collections_list).to be_empty
    end
  end
  context '#get_collections_list' do
    it 'throws an error when APO data is blank' do
      expect(subject).to receive(:read_apo_data).and_return({})
      expect { subject.get_collections_list }.to raise_error(RuntimeError, /Missing adminpolicies/)
    end
  end
  context '#get_items_list' do
    it 'throws an error when APO data is blank' do
      expect(subject).to receive(:read_apo_data).and_return({})
      expect { subject.get_items_list }.to raise_error(RuntimeError, /Missing adminpolicies/)
    end
  end
end
