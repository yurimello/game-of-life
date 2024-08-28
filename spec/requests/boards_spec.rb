require 'rails_helper'

RSpec.describe "Boards", type: :request do
  let!(:board) { create(:board) }
  describe "GET /index" do
    it "assigns all boards to @boards", :aggregate_failures do
      get boards_path
      expect(assigns(:boards)).to eq([board])
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /new" do
    it "assigns all boards to @boards", :aggregate_failures do
      get new_board_path
      expect(assigns(:board)).to be_a_new(Board)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    context "with valid attributes" do
      let(:csv) { fixture_file_upload('valid.csv', 'text/csv') }

      it "creates a new board" do
        expect {
          post boards_path, params: { board: { csv: csv } }, as: :multipart
        }.to change(Board, :count).by(1)
      end

      it "enqueues the UploadBoardJob" do
        allow(UploadBoardJob).to receive(:perform_async)
        post boards_path, params: { board: { csv: csv } }, as: :multipart
        expect(UploadBoardJob).to have_received(:perform_async)
      end

      it "redirects to the new board" do
        post boards_path, params: { board: { csv: csv } }, as: :multipart
        expect(response).to redirect_to(Board.last)
        expect(flash[:notice]).to eq('CSV file uploaded successfully.')
      end

      it "creates board state" do
        expect {
          post boards_path, params: { board: { csv: csv } }, as: :multipart
        }.to change(BoardState, :count).by(1)
      end
    end
  end
end
