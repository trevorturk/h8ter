xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title t(:title)
    xml.description t(:tagline)
    xml.link root_url
    for item in @messages
      xml.item do
        xml.title "#{item.user} hates..."
        xml.description item.body
        xml.author(item.user)
        xml.pubDate item.created_at.utc.to_s(:rfc822)
        xml.link message_url(item)
        xml.guid message_url(item)
      end
    end
  end if @messages
end