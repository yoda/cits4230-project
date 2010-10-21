class Story < ActiveRecord::Base
  acts_as_commentable
  
  belongs_to :site
  
  validates_presence_of :url, :abstract, :title, :posted_at, :site, :author_name
  attr_accessible       :url, :abstract, :title, :posted_at, :author_name
  
  named_scope :latest, :order => 'posted_at DESC'
  
  has_friendly_id :title, :use_slug => true
  
  named_scope :ordered, :order => 'posted_at DESC'
  
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

