class CreateRoleRelationships < ActiveRecord::Migration
  def change
    create_table :role_relationships do |t|
      t.integer :user_id
      t.integer :role_id
    end
    add_index :role_relationships, :user_id
    add_index :role_relationships, :role_id
    add_index :role_relationships, [:user_id, :role_id], unique: true
  end
end
