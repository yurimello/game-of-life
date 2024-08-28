class Board < ApplicationRecord
  MAX_STATES = 50
  
  has_one_attached :csv

  validates :csv, attached: true, content_type: ['text/csv', 'application/csv']
end
