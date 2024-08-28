require 'rails_helper'

RSpec.describe "Api::Boards", type: :request do
  let(:board) { create(:board) }
  let!(:board_state) { create(:board_state, board: board) }
  let(:board_serializer) { BoardsSerializer.new(board).as_json }

  describe 'GET /api/boards/:id' do
    context 'when the board exists' do
      before do
        get api_board_path(board.id)
      end

      it 'returns the board serialized data' do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq(board_serializer)
      end
    end

    context 'when the board does not exist' do
      before do
        get api_board_path(999)
      end

      it 'returns a 404 not found status' do
        expect(response).to have_http_status(:not_found)
        expect(response.body).to eq('Not Found')
      end
    end
  end

  describe 'POST /api/boards/:id/update' do
    before do
      allow(GenerateNextBoardStateJob).to receive(:perform_async).with(board.id)
      put api_board_path(board.id)
    end

    it 'enqueues GenerateNextBoardStateJob' do
      expect(GenerateNextBoardStateJob).to have_received(:perform_async).with(board.id)
    end

    context 'when the board does not exist' do
      before do
        put api_board_path(999)
      end

      it 'returns a 404 not found status' do
        expect(response).to have_http_status(:not_found)
        expect(response.body).to eq('Not Found')
      end
    end
  end
end
