require 'rails_helper'
RSpec.describe UploadBoardJob, type: :job do
  let(:board) { create(:board) }

  describe '#perform' do
    it 'calls BoardCsvParserService with the correct board' do
      # Expect BoardCsvParserService.call to be called with the board instance
      allow(BoardCsvParserService).to receive(:call).with(board)

      # Enqueue and perform the job
      described_class.perform_async(board.id)

      # Perform all enqueued jobs
      Sidekiq::Worker.drain_all

      # Trigger job execution
      expect(BoardCsvParserService).to have_received(:call).with(board)
    end
  end
end
