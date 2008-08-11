RAILS_GEM_VERSION = '2.1.0' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  require 'yaml'
  
  config.time_zone = 'UTC'
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
  SITE_URL = config_db[RAILS_ENV]['site_url']
end
