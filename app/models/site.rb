class Site < ActiveRecord::Base
  
  belongs_to :owner, :class_name => "User"
  has_many   :news_records
  
  validates_presence_of :name, :url
  
  attr_accessible :name, :url

  named_scope :approved, :conditions => {:approved => true}
  
  def to_feed
    feed               = Feedzirra::Parser::Atom.new
    feed.feed_url      = url
    feed.etag          = feed_etag
    feed.last_modified = last_modified_at
    last_entry         = news_records.latest.first
    if last_entry.present?
      feed_entry     = Feedzirra::Parser::AtomEntry.new
      feed_entry.url = last_entry.url
      feed.entries   = [feed_entry]
    end
    feed
  end
  
  def update_feed
    updated_feed = Feedzirra::Feed.update self.to_feed
    if updated_feed.updated?
      updated_feed.new_entries.each do |entry|
        news_records.build({
          :title     => entry.title.try(:sanitize),
          :url       => entry.url,
          :abstract  => (entry.content || entry.summary).try(:sanitize),
          :posted_at => entry.published
        })
      end
      self.feed_etag        = updated_feed.etag
      self.last_modified_at = updated_feed.last_modified
      updated_feed.new_entries.size
    else
      false
    end
  end
  
  def update_feed!
    self.class.transaction do
      update_feed
      save!
    end
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved
    false
  end
  
end


# == Schema Information
#
# Table name: sites
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  owner_id         :integer
#  approved         :boolean
#  url              :string(255)
#  feed_etag        :string(255)
#  last_modified_at :datetime
#  created_at       :datetime
#  updated_at       :datetime
#

