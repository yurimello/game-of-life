require 'rails_helper'

RSpec.describe BoardState, type: :model do
  let(:board) { create(:board, :valid_csv) }

  context "validations" do
    it "is valid with valid coordinates" do
      board_state = described_class.new(board: board, coordinates: [[1, 2], [3, 4]])
      expect(board_state).to be_valid
    end

    it "is invalid without coordinates" do
      board_state = described_class.new(board: board)
      expect(board_state).not_to be_valid
      expect(board_state.errors[:coordinates]).to include("can't be blank")
    end

    it "stores and retrieves serialized coordinates correctly" do
      coordinates = [[1, 2], [3, 4]]
      board_state = described_class.create!(board: board, coordinates: coordinates)

      expect(board_state.coordinates).to eq(coordinates)

      # Reloading the record to test serialization
      board_state.reload
      expect(board_state.coordinates).to eq(coordinates)
    end
  end
end
