class BoardState < ApplicationRecord
  belongs_to :board
  validates :coordinates, presence: true
  serialize :coordinates
end
