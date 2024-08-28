class Board < ApplicationRecord
  MAX_STATES = 50

  has_many :board_states, dependent: :destroy
  has_one_attached :csv

  validates :csv, attached: true, content_type: ['text/csv', 'application/csv']

  validate :max_states

  private
  def max_states
    errors.add(:board_states, 'reached max states') if board_states.count >= MAX_STATES
  end
end
