class TravelToFinalStateJob
  include Sidekiq::Job

  def perform_async(board_id)
    board = Board.find(board_id)
    sucess = true
    while success
      service = GenerateNextStateService.call(board)
      success = !service.error?
    end
  end
end
