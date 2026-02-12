class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.string :front
      t.string :context_phrase
      t.string :back
      t.datetime :show_at
      t.string :last_answer
      t.datetime :last_answer_at
      t.references :user, null: false, foreign_key: true
      t.references :pack, null: false, foreign_key: true

      t.timestamps
    end
  end
end
