class GenerateNextStateService < BaseService
  def initialize(board)
    @board = board
    super()
  end

  def call
    current_state = @board.current_state
    new_state_service = GenerateStateService.call(current_state.coordinates)
    if new_state_service.error?
      @errors = new_state_service.errors
      return self
    end
    new_coordinates = new_state_service.response[:state]
    BoardState.create(coordinates: new_coordinates, board: @board)
    @response = {board: @board.reload}
    
    self
  end
end