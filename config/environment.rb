RAILS_GEM_VERSION = '2.2.2' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  require 'yaml'
  
  config.gem 'httparty'
  config.gem 'mocha'
  
  config.time_zone = 'UTC'
  config.i18n.default_locale = :en
  config.active_record.observers = :user_observer
  config.active_record.partial_updates = true
  config_db = YAML.load_file('config/database.yml')
  
  # The session_key and secret (for verifying session data integrity) are set in config/database.yml
  config.action_controller.session = {
    :session_key => config_db[RAILS_ENV]['session_key'],
    :secret      => config_db[RAILS_ENV]['secret']
  }
  
  # The site url (with a trailing slash) and admin email are set in config/database.yml
  SITE_EMAIL = config_db[RAILS_ENV]['site_email']
  SITE_NAME = config_db[RAILS_ENV]['site_name']
  SITE_URL = config_db[RAILS_ENV]['site_url']
  TWITTER_USER = config_db[RAILS_ENV]['twitter_user']
  TWITTER_PASS = config_db[RAILS_ENV]['twitter_pass']
  TWITTER_SOURCE = config_db[RAILS_ENV]['twitter_source']
  
  GOOGLE_ANALYTICS = config_db[RAILS_ENV]['google_analytics']
  
  RE_LOGIN_RES = %w(admin all test help blog faq message messages login logout signup settings 
    register home info pages page faq follow followers following followings network networks 
    invitations invitation users user about contact status downloads api jobs tos privacy favorites 
    hate hates updates search devices device public phones phone profile profiles account accounts 
    notifications notification subscription subscriptions welcome welcomes fail fails everyone everybody)
  
end
