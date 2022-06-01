require 'net/http'
require 'uri'

class Feed
  def initialize url_in
    @url = url_in
    @feed_data = download_feed
  end

  def download_feed
    response = Util.fetch(@url)

    return nil if response.code != "200"

    return response.body
  end

  def parsed_feed
    rss = RSS::Parser.parse(@feed_data)

    rss.items.each do |item|
      og_url = item.enclosure.url
      domain = ENV['DOMAIN']
      domain += ":#{ENV['PORT']}" if ENV['USE_PORT'] != "false"
      new_url = "http://#{domain}/download?url=#{og_url}"

      item.enclosure.url = new_url
    end

    return rss.to_s
  end
end
