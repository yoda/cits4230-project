require 'test_helper'

class SiteTest < ActiveSupport::TestCase
  
  should validate_presence_of :name
  should validate_presence_of :author_name
  should validate_presence_of :url
  
  should belong_to :owner
  should have_many :news_records
  
  should allow_mass_assignment_of :name
  should allow_mass_assignment_of :author_name
  should allow_mass_assignment_of :url
  should_not allow_mass_assignment_of :owner_id
  should_not allow_mass_assignment_of :approved
  should_not allow_mass_assignment_of :last_modified_at
  should_not allow_mass_assignment_of :feed_etag
  
  context 'updateable feeds' do
    
    setup do
      @site = Site.make_unsaved
    end
    
    should 'allow to to get an updateable feed' do
      feed = @site.to_feed
      assert_equal @site.feed_url, feed.feed_url
      assert_blank feed.etag
      assert_blank feed.last_modified
      assert_kind_of Feedzirra::Parser::Atom, feed
    end
    
    should 'allow you to update the feed' do
      feed          = @site.to_feed
      updated_feed  = Object.new
      last_modified = 2.days.ago
      published_at  = 3.weeks.ago
      mock(updated_feed).updated?        { true }
      mock(updated_feed).etag            { "some-etag" }
      mock(updated_feed).last_modified   { last_modified }
      mock(@site).to_feed                { feed }
      mock(Feedzirra::Feed).update(feed) { updated_feed }
      assert_equal 0, @site.news_records.count
      mock_entry           = Feedzirra::Parser::AtomEntry.new
      mock_entry.url       = File.join(@site.url, "some-random-entry")
      mock_entry.title     = "Oh my lord, it's a ninja!"
      mock_entry.author    = "Test User"
      mock_entry.content   = "My Blog Post"
      mock_entry.published = published_at.to_s(:atom)
      # Now, set the entries.
      mock(updated_feed).new_entries.times(any_times) { [mock_entry] }
      @site.update_feed!
      assert_equal 1, @site.news_records.count
      news_record = @site.news_records.first
      assert_equal "Oh my lord, it's a ninja!", news_record.title
      assert_equal "Test User",                 news_record.author_name
      assert_equal published_at.to_s,           news_record.posted_at.to_s
      assert_equal "My Blog Post",              news_record.abstract
      assert_equal "some-etag",                 @site.feed_etag
      assert_equal last_modified,               @site.last_modified_at
    end
    
    should 'use the feeds author name when given no other option' do
      feed          = @site.to_feed
      updated_feed  = Object.new
      last_modified = 2.days.ago
      published_at  = 3.weeks.ago
      mock(updated_feed).updated?        { true }
      mock(updated_feed).etag            { "some-etag" }
      mock(updated_feed).last_modified   { last_modified }
      mock(@site).to_feed                { feed }
      mock(Feedzirra::Feed).update(feed) { updated_feed }
      assert_equal 0, @site.news_records.count
      mock_entry           = Feedzirra::Parser::AtomEntry.new
      mock_entry.url       = File.join(@site.url, "some-random-entry")
      mock_entry.title     = "Oh my lord, it's a ninja!"
      mock_entry.author    = nil
      mock_entry.content   = "My Blog Post"
      mock_entry.published = published_at.to_s(:atom)
      # Now, set the entries.
      mock(updated_feed).new_entries.times(any_times) { [mock_entry] }
      @site.update_feed!
      assert_equal 1, @site.news_records.count
      news_record = @site.news_records.first
      assert_equal @site.author_name, news_record.author_name
    end
    
    should 'return false when the feed isn\'t updated' do
      updated_feed = mock!.updated? { false }
      feed = @site.to_feed
      mock(@site).to_feed { feed }
      mock(Feedzirra::Feed).update(feed) { updated_feed }
      assert_equal false, @site.update_feed
    end
    
    should 'allow you to update the feed destructively' do
      mock(@site).update_feed { true }
      mock(@site).save!       { true }
      assert_equal true, @site.update_feed!
    end
    
    should 'allow return false if the save failed' do
      mock(@site).update_feed { true }
      mock(@site).save!       { raise ActiveRecord::RecordInvalid.new(@site) }
      assert_equal false, @site.update_feed!
    end
    
  end
  
end



# == Schema Information
#
# Table name: sites
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  author_name      :string(255)
#  owner_id         :integer
#  approved         :boolean
#  url              :string(255)
#  feed_url         :string(255)
#  cached_slug      :string(255)
#  feed_etag        :string(255)
#  last_modified_at :datetime
#  created_at       :datetime
#  updated_at       :datetime
#

