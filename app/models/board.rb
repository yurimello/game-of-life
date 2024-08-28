class Board < ApplicationRecord
  MAX_STATES = 10

  has_many :board_states, dependent: :destroy
  has_one_attached :csv

  validates :csv, attached: true, content_type: ['text/csv', 'application/csv']

  validate :max_states
  

  def current_state
    board_states.order(created_at: :desc).limit(1).first
  end

  private
  def max_states
    errors.add(:board_states, 'reached max states') if board_states.count >= MAX_STATES
  end
end
