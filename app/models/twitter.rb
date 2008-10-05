class Twitter
  include HTTParty
  base_uri 'twitter.com'
  basic_auth TWITTER_USER, TWITTER_PASS
end

# Twitter.post('/statuses/update.json', :query => {:status => "It's an HTTParty and everyone is invited!"})