require_relative './helpers/coordinates_validation'
class BaseService
  attr_reader :errors, :response
  
  def self.call(*args)
    new(*args).call
  end

  def initialize
    @errors = []
    @response = {}
  end

  def call;end

  def error?
    !errors.empty?
  end
end