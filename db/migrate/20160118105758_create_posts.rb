class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      t.integer :user_id
      t.integer :views_count, :default => 0
      t.integer :likes_count, :default => 0
      t.integer :comments_count, :default => 0
      t.timestamps null: false
    end
    add_index :posts, :user_id
    add_index :posts, [:user_id, :created_at]
  end
end
