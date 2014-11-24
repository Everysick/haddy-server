class CreateUserAuthTokens < ActiveRecord::Migration
  def change
    create_table :user_auth_tokens do |t|
      t.string :token, null: false
      t.string :token_secret, null: false
      t.integer :user_id, null: false
      t.string :service

      t.timestamps
    end
  end
end
