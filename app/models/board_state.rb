class BoardState < ApplicationRecord
  belongs_to :board
  serialize :coordinates
  
  def max_x_coords
    coordinates.map(&:first).max
  end

  def max_y_coords
    coordinates.map(&:last).max
  end
end
