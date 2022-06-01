set :port, ENV['PORT'] || 9292

get '/?' do
  return 404 if params[:url].nil?

  feed = Feed.new(params[:url])

  content_type 'application/xml'
  return feed.parsed_feed
end

get '/download' do
  return 404 if params[:url].nil?

  pod = Podcast.new(params[:url])

  content_type "application/octet-stream"
  send_file pod.get_file
end