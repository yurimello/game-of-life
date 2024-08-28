class GenerateNextBoardStateJob
  include Sidekiq::Job

  def perform(board_id)
    board = Board.find(board_id)
    GenerateNextStateService.call(board)
  end
end
