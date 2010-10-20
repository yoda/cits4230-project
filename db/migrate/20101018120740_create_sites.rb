class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string :name
      t.string :author_name
      t.belongs_to :owner
      t.boolean :approved
      t.string :url
      t.string :feed_url
      t.string :cached_slug
      t.string :feed_etag
      t.datetime :last_modified_at
      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
