ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require 'ruby-debug'
require 'redgreen' if RUBY_VERSION < '1.9'

require File.expand_path('./blueprints', File.dirname(__FILE__))

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  include RR::Adapters::TestUnit
end
