class CreateContestResults < ActiveRecord::Migration[5.0]
  def change
    create_table :contest_results do |t|
      t.string :winner, null: false
      t.string :loser, null: false
      t.references :contest, null: false, foreign_key: true

      t.timestamps
    end
  end
end
