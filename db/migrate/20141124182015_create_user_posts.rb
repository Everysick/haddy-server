class CreateUserPosts < ActiveRecord::Migration
  def change
    create_table :user_posts do |t|
      t.string :item_url, null: false
      t.binary :picture
      t.integer :user_id, null: false
      t.boolean :already_post, default: false

      t.timestamps
    end
  end
end
