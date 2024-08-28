class BoardsSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  
  attribute :coordinates do |object|
    object.current_state.coordinates
  end

  attribute :max_x_coords do |object|
    object.current_state.max_x_coords.to_i + 5
  end

  attribute :max_y_coords do |object|
    object.current_state.max_y_coords.to_i + 5
  end

  attribute :states_away do |object|
    object.board_states.count
  end
end
