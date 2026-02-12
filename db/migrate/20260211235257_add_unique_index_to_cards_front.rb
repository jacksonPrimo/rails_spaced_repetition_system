class AddUniqueIndexToCardsFront < ActiveRecord::Migration[7.1]
  def change
    add_index :cards, [:pack_id, :front], unique: true
  end
end
