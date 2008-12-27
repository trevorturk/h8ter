class Message < ActiveRecord::Base
  
  belongs_to :user, :counter_cache => true
  
  validates_presence_of :user_id, :body
  validates_length_of :body, :maximum => 115
    
  attr_accessible :body
  
  after_save :post_message_to_twitter
  
  def self.get(page = 1)
    paginate(:page => page, :per_page => 20, :order => 'created_at desc', :include => :user)
  end
  
  def post_message_to_twitter
    if TWITTER_USER && TWITTER_PASS
      Twitter.post('/statuses/update.json', 
        :query => {:status => self.user.to_s + ' hates... ' + self.body.to_s, :source => TWITTER_SOURCE})
    end
  end
  
  def to_s
    self.body
  end
  
end
