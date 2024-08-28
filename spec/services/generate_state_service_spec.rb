require 'rails_helper'

RSpec.describe GenerateStateService do
  describe '.call' do
    let(:pattern) { [[1, 2], [1, 3], [2, 2], [2, 3]] }
    let(:expected_state) { [[1, 2], [1, 3], [2, 2], [2, 3]] }
    let(:validation_error_message) { 'only positive numbers are allowed' }

    subject(:response) { described_class.call(pattern).response }
    
    it 'responds with next state' do
      expect(response[:state]).to eq(expected_state)
    end

    context 'with negative number' do
      let(:pattern) { [[1, 2], [1, 3], [2, 2], [-2, 3]] }
      subject(:service_object) { described_class.call(pattern) }
      

      it 'has errors', :aggregate_failures do
        expect(service_object.errors).to include(validation_error_message)
        expect(service_object.error?).to be_truthy
      end
    end

    context 'with chars' do
      let(:pattern) { [[1, 2], [1, 3], ['a', 2], [2, 3]] }
      subject(:service_object) { described_class.call(pattern) }
      

      it 'has errors', :aggregate_failures do
        expect(service_object.errors).to include(validation_error_message)
        expect(service_object.error?).to be_truthy
      end
    end
  end
end
