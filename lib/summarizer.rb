require 'nokogiri'
require 'httparty'

class Summarizer

  def initialize(text)
    @summarized = nil
    @text       = Nokogiri::HTML.parse(text.to_s.strip).at('body').text.squeeze(" ").squeeze("\n")
  end

  def summarized
    @summarized ||= summarize_text
  end

  protected

  def summarize_text(ratio = 25, language = "en")
    HTTParty.post('http://cits4230.sutto.net/ots.php', :body => {:text => @text, :type => "sum", :ratio => ratio, :lang => language}).to_s.strip
  end

end