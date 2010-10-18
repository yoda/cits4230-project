class NewsRecord < ActiveRecord::Base
end

# == Schema Information
#
# Table name: news_records
#
#  id          :integer         not null, primary key
#  url         :string(255)
#  description :text
#  title       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

