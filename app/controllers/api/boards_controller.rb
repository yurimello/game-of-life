class Api::BoardsController < ApplicationController
  def show
    board = Board.find(params[:id])
    if board.board_states.empty?
      render json: {isProcessing: true}
    else
      render json: BoardsSerializer.new(board)
    end
  end
end
