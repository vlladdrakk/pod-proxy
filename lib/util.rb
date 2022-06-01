require 'net/http'
require 'uri'

class Util
  def self.fetch(uri_str, limit = 10)
    raise ArgumentError, 'HTTP redirect too deep' if limit == 0

    url = URI.parse(uri_str)
    req = Net::HTTP::Get.new(url.path, { 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:100.0) Gecko/20100101 Firefox/100.0' })
    response = Net::HTTP.start(url.host, url.port, use_ssl: true) { |http| http.request(req) }
    case response
    when Net::HTTPSuccess     then response
    when Net::HTTPRedirection then fetch(response['location'], limit - 1)
    else
      response.error!
    end
  end
end
