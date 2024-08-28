require 'rails_helper'

RSpec.describe Board, type: :model do
  describe '.validations' do
    it "is valid with a valid CSV file" do
      csv_file = fixture_file_upload('valid.csv', 'text/csv')
      board = described_class.new(csv: csv_file)
      expect(board).to be_valid
    end
    
    it "is invalid without an attached CSV file", :aggregate_failures do
      board = described_class.new
      expect(board).not_to be_valid
      expect(board.errors[:csv]).to include("can't be blank")
    end

    it "is invalid with an incorrect MIME type", :aggregate_failures do
      csv_file = fixture_file_upload('invalid.txt', 'text/plain')
      board = described_class.new(csv: csv_file)
      expect(board).not_to be_valid
      expect(board.errors[:csv]).to include("has an invalid content type")
    end
  end
end
