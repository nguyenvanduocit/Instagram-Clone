class CreateHashtagRelationships < ActiveRecord::Migration
  def change
    create_table :hashtag_relationships do |t|
      t.integer :post_id
      t.integer :hashtag_id

      t.timestamps null: false
    end
    add_index :hashtag_relationships, :post_id
    add_index :hashtag_relationships, :hashtag_id
    add_index :hashtag_relationships, [:post_id, :hashtag_id], unique: true
  end
end
