require 'net/http'
require 'uri'

class Util
  def self.fetch(uri_str, limit = 10, agent = UserAgents.rand(), cookies = '')
    raise ArgumentError, 'HTTP redirect too deep' if limit == 0

    url = URI.parse(CGI.unescape(uri_str))
    req = Net::HTTP::Get.new(url, { 'User-Agent' => agent, 'Cookie' => cookies })
    response = Net::HTTP.start(url.host, url.port, use_ssl: true) { |http| http.request(req) }

    puts "request url: #{uri_str}"

    case response
    when Net::HTTPSuccess then response
    when Net::HTTPRedirection
      all_cookies = response.get_fields('set-cookie')

      unless all_cookies.nil?
        cookies_array = Array.new
        all_cookies.each { | cookie |
            cookies_array.push(cookie.split('; ')[0])
        }
        cookies = cookies_array.join('; ')
      else
        cookies = ''
      end

      puts "REDIRECTING"
      puts "request cookies: #{cookies}"
      puts "redirecting to: #{response['location']}"
      fetch(response['location'], limit - 1, agent, cookies)
    else
      puts "response body: #{response.body}"
      response.error!
    end
  end
end
