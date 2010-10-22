class BlakstarLikeMigration < ActiveRecord::Migration
  def self.up    
    create_table :likes do |t|
    	t.references :user
      t.integer :likeable_id
      t.string :likeable_type, :limit => 32
      t.integer :value
      t.timestamps
    end
    
    add_index :likes, :user_id
    add_index :likes, :likeable_id
    add_index :likes, :likeable_type
    add_index :likes, :value
    add_index :likes, :created_at
    add_index :likes, [:user_id, :likeable_id, :likeable_type], :unique => true
    
  end
  
  def self.down
    drop_table :likes
  end
end
