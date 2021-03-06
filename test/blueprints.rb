require 'machinist/active_record'
require 'sham'
require 'ffaker'

Site.blueprint do
  name        { Faker::Company.name }
  author_name { Faker::Name.name }
  url         { "http://#{Faker::Internet.domain_name}/" }
  feed_url    { File.join(url, "feed.rss") }
end

Story.blueprint do
  site
  url         { File.join(site.url, "some-new-blog-post-#{rand(10000)}") }
  content     { "Some entry" }
  title       { "Some title" }
  posted_at   { 3.weeks.ago }
  author_name { "Darcy Laycock" }
end
