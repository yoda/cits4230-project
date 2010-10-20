class NewsRecord < ActiveRecord::Base
  
  belongs_to :site
  
  validates_presence_of :url, :abstract, :title, :posted_at, :site
  attr_accessible       :url, :abstract, :title, :posted_at
  
  named_scope :latest, :order => 'posted_at DESC'
  
end


# == Schema Information
#
# Table name: news_records
#
#  id         :integer         not null, primary key
#  url        :string(255)
#  abstract   :text
#  title      :string(255)
#  site_id    :integer
#  posted_at  :datetime
#  created_at :datetime
#  updated_at :datetime
#

