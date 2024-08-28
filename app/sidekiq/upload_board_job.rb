require 'csv'
class UploadBoardJob
  include Sidekiq::Job

  def perform(board_id)
    coordinates = []
    board = Board.find(board_id)
    file = board.csv.download
    CSV.parse(file, headers: true) do |row| 
      coordinates << [row[0].to_i, row[1].to_i]
    end
    BoardState.create(coordinates: coordinates, board: board)
  end
end
