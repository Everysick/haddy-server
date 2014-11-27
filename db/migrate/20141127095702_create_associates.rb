class CreateAssociates < ActiveRecord::Migration
  def change
    create_table :associates do |t|
      t.string :token
      t.integer :user_id

      t.timestamps
    end
  end
end
