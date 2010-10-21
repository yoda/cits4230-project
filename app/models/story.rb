class Story < ActiveRecord::Base
  
  belongs_to :site
  
  validates_presence_of :url, :content, :title, :posted_at, :site, :author_name
  attr_accessible       :url, :abstract, :content, :title, :posted_at, :author_name
  
  named_scope :latest, :order => 'posted_at DESC'
  
  has_friendly_id :title, :use_slug => true
  
  named_scope :ordered, :order => 'posted_at DESC'

  before_save :generate_abstract

  def generate_abstract
    abstract = Nokogiri::HTML(self.content.to_s).css('p').first.try(:to_html)
    abstract = content.split(/\n+/).first if abstract.blank?
    self.abstract = abstract
  end
  
  def content=(value)
    if value.blank?
      write_attribute :content, nil
    else
      write_attribute :content, normalize_html(value)
    end
  end
  
  protected
  
  def normalize_html(html)
    doc = Nokogiri::HTML(html.to_s.strip)
    doc.search('a') do |link|
      href = link['href'].to_s
      link['href'] = File.join(site.url, href) if href.present? && href =~ /^\//
    end
    # TODO: Search for images, download and resize here.
    doc.at('*').to_html
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

