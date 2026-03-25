class UpdateFieldsInCards < ActiveRecord::Migration[7.1]
  def change
    rename_column :cards, :show_at, :next_review_at
    remove_column :cards, :last_answer_at, :datetime
    add_column :cards, :waiting_time, :interval
  end
end
