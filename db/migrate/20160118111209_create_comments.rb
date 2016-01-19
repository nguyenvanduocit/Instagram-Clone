class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :post_id
      t.timestamps null: false
    end
    add_index :comments, :post_id
    add_index :comments, [:id, :post_id], unique: true
  end
end
