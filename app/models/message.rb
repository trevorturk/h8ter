class Message < ActiveRecord::Base
  
  validates_presence_of :user_id, :body
  validates_length_of :body, :maximum => 115
  attr_accessible :body
  belongs_to :user, :counter_cache => true
  after_save :post_message_to_twitter
  
  def self.get(page = 1)
    paginate(:page => page, :per_page => 20, :order => 'created_at desc', :include => :user)
  end
  
  def post_message_to_twitter
    if TWITTER_USER && TWITTER_PASS
      Twitter.post('/statuses/update.json', 
        :query => {:status => @message.user.to_s + ' hates... ' + @message.body.to_s, :source => TWITTER_SOURCE})
    end
  end
  
  def to_s
    self.body
  end
  
end
