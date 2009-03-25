class Twitter
  include HTTParty
  base_uri 'twitter.com'
  basic_auth CONFIG['twitter_user'], CONFIG['twitter_pass']
end