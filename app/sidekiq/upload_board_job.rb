class UploadBoardJob
  include Sidekiq::Job

  def perform(board_id)
    board = Board.find(board_id)
    BoardCsvParserService.call(board)
  end
end
