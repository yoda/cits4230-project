require File.dirname(__FILE__) + '/lib/blakstar_like'
ActiveRecord::Base.send(:include, ActiveRecord::Blakstar::Like)
