require 'test_helper'

class SiteTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
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

