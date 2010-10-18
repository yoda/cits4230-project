require 'test_helper'

class NewsRecordTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
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

