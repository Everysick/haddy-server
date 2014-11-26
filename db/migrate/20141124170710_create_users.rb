class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      # User screen name
      t.string :name

      # user role
      t.string :role

      # Authentication token
      t.string :authentication_token

      t.timestamps
    end

    add_index :users, :authentication_token, unique: true
  end
end
