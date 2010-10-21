require 'test_helper'

class SiteTest < ActiveSupport::TestCase
  
  should validate_presence_of :name
  should validate_presence_of :author_name
  should validate_presence_of :url
  
  should belong_to :owner
  should have_many :story
  
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
    
    should 'set the entries on the feed if present' do
      @site.save
      entry = Story.make(:site => @site)
      feed = @site.to_feed
      assert feed.entries.present?
      entry = feed.entries.last
      assert_equal entry.url, entry.url
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
      assert_equal 0, @site.story.count
      mock_entry           = Feedzirra::Parser::AtomEntry.new
      mock_entry.url       = File.join(@site.url, "some-random-entry")
      mock_entry.title     = "Oh my lord, it's a ninja!"
      mock_entry.author    = "Test User"
      mock_entry.content   = "My Blog Post"
      mock_entry.published = published_at.to_s(:atom)
      # Now, set the entries.
      mock(updated_feed).new_entries.times(any_times) { [mock_entry] }
      @site.update_feed!
      assert_equal 1, @site.story.count
      story = @site.story.first
      assert_equal "Oh my lord, it's a ninja!", story.title
      assert_equal "Test User",                 story.author_name
      assert_equal published_at.to_s,           story.posted_at.to_s
      assert_equal "My Blog Post",              story.abstract
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
      assert_equal 0, @site.story.count
      mock_entry           = Feedzirra::Parser::AtomEntry.new
      mock_entry.url       = File.join(@site.url, "some-random-entry")
      mock_entry.title     = "Oh my lord, it's a ninja!"
      mock_entry.author    = nil
      mock_entry.content   = "My Blog Post"
      mock_entry.published = published_at.to_s(:atom)
      # Now, set the entries.
      mock(updated_feed).new_entries.times(any_times) { [mock_entry] }
      @site.update_feed!
      assert_equal 1, @site.story.count
      story = @site.story.first
      assert_equal @site.author_name, story.author_name
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
  
  context 'validations' do
    
    setup do
      @site = Site.make_unsaved(:url => nil, :feed_url => nil)
      stub(Site).feeds_for_url(anything) { ["http://my-feed.com/rss"] }
    end
    
    should_not allow_value("localhost").for(:url)
    should_not allow_value("BLAH BLAM").for(:url)
    should_not allow_value("fennec fox.").for(:url)
    should_not allow_value("127.0.0.1").for(:url)
    should_not allow_value("blog.ninjahideout.com").for(:url)
    should_not allow_value("blog.ninjahideout.com/a").for(:url)
    should allow_value("http://blog.ninjahideout.com").for(:url)
    should allow_value("http://blog.ninjahideout.com/a").for(:url)
    
    should_not allow_value("localhost").for(:feed_url)
    should_not allow_value("BLAH BLAM").for(:feed_url)
    should_not allow_value("fennec fox.").for(:feed_url)
    should_not allow_value("127.0.0.1").for(:feed_url)
    should_not allow_value("blog.ninjahideout.com").for(:feed_url)
    should_not allow_value("blog.ninjahideout.com/a").for(:feed_url)
    should allow_value("http://blog.ninjahideout.com").for(:feed_url)
    should allow_value("http://blog.ninjahideout.com/a").for(:feed_url)
    
    should 'automatically load feed suggestions if the feed url is missing' do
      mock(Site).feeds_for_url("http://blog.ninjahideout.com/") { ["http://blog.ninjahideout.com/posts.rss", "http://blog.ninjahideout.com/posts/full.rss"] }
      @site.url = "http://blog.ninjahideout.com/"
      assert !@site.valid?
      assert @site.errors.invalid?(:url)
      assert Array(@site.errors.on(:url)).to_sentence.include?("multiple")
      assert_equal ["http://blog.ninjahideout.com/posts.rss", "http://blog.ninjahideout.com/posts/full.rss"], @site.feed_choices
    end
    
    should 'add an error when the url doesn\'t contain valid feeds and feed_url is blank' do
      mock(Site).feeds_for_url("http://blog.ninjahideout.com/") { [] }
      @site.url = "http://blog.ninjahideout.com/"
      assert !@site.valid?
      assert @site.errors.invalid?(:url)
      assert Array(@site.errors.on(:url)).to_sentence.include?("does not contain a feed or a page pointing to a feed")
    end
    
    should 'deal with errors finding feeds correctly' do
      mock(Site).feeds_for_url("http://blog.ninjahideout.com/") { raise FeedFinder::UrlError.new("http://blog.ninjahideout.com/") }
      @site.url = "http://blog.ninjahideout.com/"
      assert !@site.valid?
      assert @site.errors.invalid?(:url)
      assert Array(@site.errors.on(:url)).to_sentence.include?("is not a valid url")
    end

  end
  
  context 'approving' do
    
    should 'default to unapproved' do
      assert !Site.make.approved?
    end
    
    should 'let you approve it' do
      site = Site.make
      site.approve!
      assert site.approved?
    end
    
    should 'let you find approved sites' do
      site_a = Site.make
      site_b = Site.make
      site_c = Site.make
      site_a.approve!
      assert_equal [site_a], Site.approved.all
      site_b.approve!
      assert_equal [site_a, site_b], Site.approved.all
    end
    
  end
  
  context 'finding feeds' do

    should 'use feed finder' do
      mock(FeedFinder).feeds("test.com") { %w(a b) }
      assert_equal %w(a b), Site.feeds_for_url("test.com")
    end

    should 'make sure the result is an array' do
      mock(FeedFinder).feeds("test.com") { nil }
      assert_equal [], Site.feeds_for_url("test.com")
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

