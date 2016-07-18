class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.string :battlepets, array: true
      t.string :contest_type, default: 'simple'
      t.string :battlepet_traits, array: true

      t.timestamps
    end
  end
end
