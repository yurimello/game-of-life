require 'rails_helper'

RSpec.describe BoardCsvParserService do
  describe '.call' do
    context 'with valid csv' do
      let(:board) { create(:board, :valid_csv) }
      

      subject(:response) { described_class.call(board).response }
      
      it 'responds with board and state', :aggregate_failures do
        expect(response[:board]).to eq(board)
        expect(response[:board_state]).to eq(board.reload.board_states.last)
      end
    end

    context 'with invalid csv' do
      let(:board) { create(:board, :invalid_csv) }
      

      subject(:service) { described_class.call(board) }
      let(:response) { service.response }

      it 'responds with board and state', :aggregate_failures do
        expect(response[:board]).to eq(nil)
        expect(response[:board_state]).to eq(nil)
        expect(service.errors).to include('only positive numbers are allowed')
      end
    end
  end
end
