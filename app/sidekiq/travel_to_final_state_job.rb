class TravelToFinalStateJob
  include Sidekiq::Job

  def perform(board_id)
    board = Board.find(board_id)
    success = true
    while success
      service = GenerateNextStateService.call(board)
      success = !service.error?
      sleep 1 # just for rendering "animation" porpouses
    end
  end
end
