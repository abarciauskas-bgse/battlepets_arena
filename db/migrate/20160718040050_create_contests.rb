class CreateContests < ActiveRecord::Migration[5.0]
  def change
    create_table :contests do |t|
      t.string :battlepets, array: true
      t.string :contest_type, null: false

      t.timestamps
    end
  end
end
