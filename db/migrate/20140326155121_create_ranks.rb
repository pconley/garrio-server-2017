class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.integer :score
      t.integer :user_id
      t.integer :language_id

      t.timestamps
    end
  end
end
