class CreateNewsRecords < ActiveRecord::Migration
  def self.up
    create_table :news_records do |t|
      t.string :url
      t.text    :abstract
      t.string :title
      t.string :author_name
      t.belongs_to :site
      t.datetime :posted_at
      t.string :cached_slug
      t.timestamps
    end
  end

  def self.down
    drop_table :news_records
  end
end
