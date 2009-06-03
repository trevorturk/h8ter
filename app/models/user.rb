require 'digest/sha1'

class User < ActiveRecord::Base

  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  attr_accessible :login, :email, :password, :password_confirmation

  validates_presence_of     :login
  validates_length_of       :login,    :within => 1..15
  validates_uniqueness_of   :login,    :case_sensitive => false
  validates_format_of       :login,    :with => /^[a-zA-Z0-9\_]*?$/, :message => "can only contain letters, numbers and underscores"
  validates_exclusion_of    :login,    :in => RE_LOGIN_RES, :message => "is a reserved word"
  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 
  validates_uniqueness_of   :email,    :case_sensitive => false
  validates_format_of       :email,    :with => RE_EMAIL_OK, :message => MSG_EMAIL_BAD
  
  has_many :messages, :order => 'created_at desc'
  
  def self.authenticate(login, password)
    u = find :first, :conditions => ['LOWER(login) = ?', login.downcase]
    u && u.authenticated?(password) ? u : nil
  end
  
  def self.top(limit = 25)
    User.all(:limit => limit, :order => 'messages_count desc')
  end
  
  def to_s
    self.login
  end
    
end
