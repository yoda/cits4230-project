require 'test_helper'

class NewsRecordTest < ActiveSupport::TestCase
  
  should belong_to :site
  
  should validate_presence_of :url
  should validate_presence_of :title
  should validate_presence_of :abstract
  should validate_presence_of :posted_at
  should validate_presence_of :site
  
  should allow_mass_assignment_of :url
  should allow_mass_assignment_of :title
  should allow_mass_assignment_of :abstract
  should allow_mass_assignment_of :posted_at
  
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

