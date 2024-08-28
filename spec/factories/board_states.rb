FactoryBot.define do
  factory :board_state do
    board     
    coordinates { [[1,2], [2,2]] }
  end
end
