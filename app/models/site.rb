class Site < ActiveRecord::Base
  belongs_to :owner, :class_name => "User"
  
  attr_accessible :name, :url
  
  named_scope :approved, :conditions => {:approved => true}
  
  def update!
  end
  
end

# == Schema Information
#
# Table name: sites
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  owner_id        :integer
#  approved        :boolean
#  url             :string(255)
#  last_fetched_at :datetime
#  created_at      :datetime
#  updated_at      :datetime
#

