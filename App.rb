set :port, ENV['PORT'] || 9292

get '/?' do
  url = request.fullpath.gsub('/download?url=', '')

  return 404 if url.nil?

  feed = Feed.new(url)

  content_type 'application/xml'
  return feed.parsed_feed
end

get '/download' do
  url = request.fullpath.gsub('/download?url=', '')

  return 404 if url.nil?

  pod = Podcast.new(url)

  content_type "application/octet-stream"
  send_file pod.get_file
end