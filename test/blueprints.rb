require 'machinist/active_record'
require 'sham'
require 'ffaker'

Site.blueprint do
  name        { Faker::Company.name }
  author_name { Faker::Name.name }
  url         { "http://#{Faker::Internet.domain_name}/" }
  feed_url    { File.join(url, "feed.rss") }
end

NewsRecord.blueprint do
  
end