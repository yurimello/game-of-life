require 'csv'
class BoardCsvParserService < BaseService
  include CoordinatesValidation

  def initialize(board)
    @board = board
    @response = {board: nil, board_state: nil}
    @errors = []
  end

  def call
    coordinates = []
    file = @board.csv.download
    CSV.parse(file, headers: true) do |row| 
      coordinates << [row[0].to_i, row[1].to_i]
    end
    return self unless validate_coordinates(coordinates)
    
    board_state = BoardState.create(coordinates: coordinates, board: @board)
    @response = {
      board: @board,
      board_state: board_state
    }
    self
  end
end