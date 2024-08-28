class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def new
    @board = Board.new
  end

  def show
    @board = Board.find(params[:id])
  end

  def create
    @board = Board.new(board_params)

    if @board.save
      UploadBoardJob.perform_async(@board.id)
      redirect_to @board, notice: 'CSV file uploaded successfully.'
    else
      render :new
    end
  end

  private

  def board_params
    params.require(:board).permit(:csv)
  end
end
