class GenerateNextStateService < BaseService
  def initialize(board)
    @board = board
    super()
  end

  def call
    return self if reached_max_states?
    current_state = @board.current_state
    new_state_service = GenerateStateService.call(current_state.coordinates)
    
    if new_state_service.error?
      reached_final_state(new_state_service.errors.first)
      return self
    end
    new_coordinates = new_state_service.response[:state]
    
    return self if not_changing_state?(current_state.coordinates, new_coordinates)
    return self if have_seen?(new_coordinates)
    
    BoardState.create(coordinates: new_coordinates, board: @board)
    @board.reload # it must reload relationships
    @response = {board: @board}
    ActionCable.server.broadcast "notifications_#{@board.id}", {board: BoardsSerializer.new(@board)}
    self
  end

  private
  def reached_max_states?
    puts 'reached_max_states?'

    return false if @board.board_states.count < Board::MAX_STATES 
    
    reached_final_state('reached max states')
  end

  def not_changing_state?(current_coordinates, new_coordinates)
    puts 'not_changing_state?'
    return false if current_coordinates != new_coordinates
    
    reached_final_state
  end

  def have_seen?(new_coordinates)
    puts 'have_seen?'
    all_coordinates = @board.board_states.map(&:coordinates)
    return false unless all_coordinates.include?(new_coordinates)

    reached_final_state
  end

  def reached_final_state(message = 'reached final state')
    @errors << message
    ActionCable.server.broadcast "notifications_#{@board.id}", {message: message}
    true
  end
end