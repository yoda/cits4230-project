class CreateNewsRecords < ActiveRecord::Migration
  def self.up
    create_table :news_records do |t|
      t.string :url
      t.text :description
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :news_records
  end
end
