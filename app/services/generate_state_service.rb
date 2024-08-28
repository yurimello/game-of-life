class GenerateStateService < BaseService
  include CoordinatesValidation

  def initialize(coordinates)
    @coordinates = coordinates
    @response = {state: []}
    @errors = []
  end

  def call
    return self unless validate_coordinates(@coordinates)

    new_state = []
    (0..x_max).each do |x|
      (0..y_max).each do |y|
        live_neighbors_count = live_neighbors(x, y)
    
        if cell_lives?(x, y)
          new_state << [x, y] if live_neighbors_count.between?(2, 3)
        else
          new_state << [x, y] if live_neighbors_count == 3
        end
      end
    end
    @response[:state] = new_state
    self
  end

  private

  def neighbors_offsets
    @neighbors_offsets ||= [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1],           [0, 1],
      [1, -1],  [1, 0],  [1, 1]
    ]
  end

  def live_neighbors(x, y)
    count = 0
    neighbors_offsets.each do |off_x, off_y|
      new_x = x + off_x
      new_y = y + off_y
      count += 1 if cell_lives?(new_x, new_y)
    end
    count
  end

  def cell_lives?(x, y)
    @coordinates.include?([x, y])
  end

  def x_max
    @x_max ||= @coordinates.map(&:first).max
  end

  def y_max
    @y_max ||= @coordinates.map(&:last).max
  end
  
  
end