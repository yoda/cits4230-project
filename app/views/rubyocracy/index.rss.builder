xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Stories"
    xml.description "Rubyocracy's Latest Stories"
    xml.link link_to '', root_path, params.merge(:format => :rss)
    @stories.each do | story |
      xml.item do
        xml.title story.title
        xml.description story.content
        xml.pubDate story.created_at.to_s(:rfc822)
        xml.link link_to '', story.url, params.merge(:format => :rss)
        xml.guid link_to '', [story.site, story], params.merge(:format => :rss)
      end
    end
  end
end

