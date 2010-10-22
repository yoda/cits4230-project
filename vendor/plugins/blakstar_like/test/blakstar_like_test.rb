require 'test_helper'
require 'active_record'
require "#{File.dirname(__FILE__)}/../init"
require "#{File.dirname(__FILE__)}/../lib/like"

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

def setup_db
  ActiveRecord::Schema.define(:version => 1) do
    create_table :posts do |t|
      t.string :title
      t.integer :likes_count, :default => 0
      t.integer :dislikes_count, :default => 0
      t.timestamps
    end
    create_table :users do |t|
      t.string :name, :null => false
    end
    create_table :likes do |t|
    	t.references :user
      t.integer :likeable_id
      t.string :likeable_type, :limit => 32
      t.integer :value
      t.timestamps
    end
  end
end

def teardown_db
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end

class User < ActiveRecord::Base; end
class Post < ActiveRecord::Base; blakstar_like; end

class BlakstarLikeTest < Test::Unit::TestCase
  
  def setup
    setup_db
    5.times {|i| Post.create! :title => "Post #{i}"}
    2.times {|i| User.create! :name => "User #{i}"}
  end
  
  def teardown
    teardown_db
  end
  
  def test_like
    user = User.find 1
    post = Post.find 1
    like = post.like! user
    assert_equal 'Like', like.class.to_s
    assert !like.changed?
  end
  
  def test_dislike
    user = User.find 2
    post = Post.find 1
    like = post.dislike! user
    assert_equal 'Like', like.class.to_s
    assert !like.changed?
  end

end
