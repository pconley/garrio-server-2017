class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :language_id
      t.string :password_digest
      
      t.boolean :admin, default: false
      t.boolean :activated, default: false
      t.boolean :remember_me, default: false
            
      t.string   "session_token"
      t.string   "registration_token"
      t.string   "password_reset_token"
      
      t.datetime "session_token_created_at"
      t.datetime "registration_token_created_at"
      t.datetime "password_reset_token_created_at"
      
      t.datetime "activated_at"
      t.datetime "last_login_at"

      t.timestamps
    end
  end
end
