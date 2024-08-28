class UploadBoardJob
  include Sidekiq::Job

  def perform(board_id)
    board = Board.find(board_id)
    
    board.reload
    ActionCable.server.broadcast "notifications_#{board.id}", {message: 'Board created!', data: BoardsSerializer.new(board)}
  end
end
