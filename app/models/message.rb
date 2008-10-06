class Message < ActiveRecord::Base
  
  validates_presence_of :user_id, :body
  validates_length_of :body, :maximum => 140
  attr_accessible :body
  belongs_to :user, :counter_cache => true
  after_create :create_twitter_post
  
  def self.get(page = 1)
    paginate(:page => page, :per_page => 20, :order => 'created_at desc', :include => :user)
  end
  
  def create_twitter_post
    Twitter.post('/statuses/update.json', :query => {:status => self.body}) if TWITTER_USER && TWITTER_PASS
  end
  
  def to_s
    self.body
  end
  
end
