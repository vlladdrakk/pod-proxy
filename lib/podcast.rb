require 'net/http'
require 'uri'

class Podcast
  def initialize url
    @url = url
  end

  def get_file
    response = Util.fetch(@url)

    return nil if response.code != "200"

    f = Tempfile.new
    f.write(response.body)
    return f
  end
end
