module CoordinatesValidation
  private
  def validate_coordinates(coordinates)
    @errors = []
    if coordinates.flatten.any?(&:negative?)
      @errors << 'only positive numbers are allowed' 
      return false
    end
    true 
  rescue NoMethodError
    @errors << 'only positive numbers are allowed' 
    return false
  end
end