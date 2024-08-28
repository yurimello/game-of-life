require 'rails_helper'

RSpec.describe GenerateNextStateService, type: :service do
  let(:board) { create(:board) }
  let(:current_state) { double('CurrentState', coordinates: [1, 2, 3]) }

  before do
    allow(board).to receive(:current_state).and_return(current_state)
  end

  describe '#call' do
    context 'when GenerateStateService succeeds' do
      let(:new_coordinates) { [4, 5, 6] }
      let(:new_state_service) { double('GenerateStateService', error?: false, response: { state: new_coordinates }) }

      before do
        allow(GenerateStateService).to receive(:call).with(current_state.coordinates).and_return(new_state_service)
      end

      it 'creates a new BoardState' do
        expect {
          GenerateNextStateService.new(board).call
        }.to change(BoardState, :count).by(1)
      end

    end

    context 'when GenerateStateService fails' do
      let(:error_message) { 'An error occurred' }
      let(:new_state_service) { double('GenerateStateService', error?: true, errors: [error_message]) }

      before do
        allow(GenerateStateService).to receive(:call).with(current_state.coordinates).and_return(new_state_service)
      end

      it 'does not create a new BoardState' do
        expect {
          GenerateNextStateService.new(board).call
        }.not_to change(BoardState, :count)
      end

      it 'returns errors' do
        service = GenerateNextStateService.new(board).call
        expect(service.errors).to eq([error_message])
      end
    end
  end
end