class Twitter
  include HTTParty
  base_uri 'twitter.com'
  basic_auth TWITTER_USER, TWITTER_PASS
end