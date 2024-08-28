class Api::BoardsController < ApplicationController
  def show
    board = Board.find(params[:id])
    render json: BoardsSerializer.new(board)
  end

  def update
    board = Board.find(params[:id])
    GenerateNextBoardStateJob.perform_async(board.id)
    render json: {generating: true}
  end

  def final_states
    board = Board.find(params[:id])
    TravelToFinalStateJob.perform_async(board.id)
    render json: {generating: true}
  end
end
