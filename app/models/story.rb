require 'open-uri'

class Story < ActiveRecord::Base
  acts_as_commentable
  blakstar_like
  acts_as_favorite
  
  belongs_to :site
  
  validates_presence_of :url, :content, :title, :posted_at, :site, :author_name
  attr_accessible       :url, :abstract, :content, :title, :posted_at, :author_name
  
  named_scope :latest, :order => 'posted_at DESC'
  
  has_friendly_id :title, :use_slug => true
  
  named_scope :ordered, :order => 'posted_at DESC'

  acts_as_taggable_on :categories

  acts_as_indexed :fields => [:normalized_content, :humanized_category_names]

  before_save  :generate_abstract
  before_save  :generate_categories
  after_create :cache_pinky_url!

  def generate_abstract
    abstract = Nokogiri::HTML(self.content.to_s).css('p').first.try(:to_html)
    abstract = content.split(/\n+/).first if abstract.blank?
    self.abstract = abstract
  end
  
  def generate_categories
    keywords = Pismo::Document.new(content.to_s).keywords[0, 5].map(&:first)
    self.category_list = (keywords + ["ruby"]).compact.uniq
  end
  
  def humanized_category_names
    Array(category_list).join(", ")
  end
  
  def content=(value)
    if value.blank?
      write_attribute :content, nil
    else
      write_attribute :content, normalize_html(value)
    end
  end
  
  def normalized_content
    Nokogiri::HTML(content.to_s).text.strip
  end
  
  def self.popular_keywords_from(scope, max = 10)
    counts = scope.tag_counts_on :categories
    counts.sort_by(&:count).reverse[0, max].map(&:name)
  end
  
  def cache_pinky_url!
    uri = "http://pinkyurl.com/i?url=#{URI.escape(url)}&out-format=png&resize=160&crop=160x140"
    open(uri).read rescue nil
    nil
  end
  
  protected
  
  def normalize_html(html)
    doc = Nokogiri::HTML(html.to_s.strip)
    normalize_attributes doc, 'a', 'href'
    normalize_attributes doc, 'img', 'src'
    normalize_images doc
    doc.search('body').inner_html
  end
  
  def normalize_images(doc)
    doc.search('img').each do |img|
      src = img['src']
      if src.present? && src !~ /&\//
        image = Image.from_url(src)
        img['src'] = image.url if image.present?
      end
    end
  end
  
  def normalize_attributes(doc, selector, field)
    doc.search(selector).each do |item|
      href = item[field].to_s
      url = URI.parse(url).merge(URI.parse("/")).to_s rescue nil
      if href.present? && href =~ /^\// && url.present?
        full_url = File.join(url, href)
        item[field] = full_url
      end
    end
  end
  
end



# == Schema Information
#
# Table name: story
#
#  id          :integer         not null, primary key
#  url         :string(255)
#  abstract    :text
#  title       :string(255)
#  author_name :string(255)
#  site_id     :integer
#  posted_at   :datetime
#  cached_slug :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

