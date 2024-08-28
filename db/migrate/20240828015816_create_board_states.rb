class CreateBoardStates < ActiveRecord::Migration[7.0]
  def change
    create_table :board_states do |t|
      t.references :board, null: false, foreign_key: true
      t.text :coordinates

      t.timestamps
    end
  end
end
