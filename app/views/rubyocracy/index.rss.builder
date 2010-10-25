xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Stories"
    xml.description "Rubyocracy's Latest Stories"
    xml.link root_url
    @stories.each do | story |
      xml.item do
        xml.title story.title
        xml.description story.content.html_safe
        xml.pubDate story.created_at.to_s(:rfc822)
        xml.link story.url
        xml.guid polymorphic_url([story.site, story])
      end
    end
  end
end

