class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.string :url
      t.text   :content
      t.text   :abstract
      t.string :title
      t.string :author_name
      t.belongs_to :site
      t.datetime :posted_at
      t.string :cached_slug
      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end
