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
    end
    
    should 'allow to to get an updateable feed' do
    end
    
    should 'allow you to update the feed' do
    end
    
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

