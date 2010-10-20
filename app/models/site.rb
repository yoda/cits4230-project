class Site < ActiveRecord::Base
  
  belongs_to :owner, :class_name => "User"
  has_many   :news_records
  
  validates_presence_of :name, :url, :author_name
  
  attr_accessible :name, :url, :self_authored, :author_name
  
  attr_accessor :self_authored

  named_scope :approved, :conditions => {:approved => true}
  
  validate :validate_feed_url
  
  has_friendly_id :name, :use_slug => true
  
  def approve!
    update_attribute :approved, true
  end
  
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
  
  attr_reader :feed_choices
  
  def validate_feed_url
    return if url.blank?
    feeds = self.class.feeds_for_url(url)
    if feeds.blank?
      errors.add :url, "does not contain a feed or a page pointing to a feed"
    elsif feeds.size == 1
      self.url = feeds.first
    else
      @feed_choices = feeds
      errors.add :url, "contains multiple feeds - please choose one"
    end
  rescue FeedFinder::UrlError
    errors.add :url, "is not a valid url"
  end
  
  def self.feeds_for_url(url)
    Array(FeedFinder.feeds(url))
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

