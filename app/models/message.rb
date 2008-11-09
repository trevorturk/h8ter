class Message < ActiveRecord::Base
  
  validates_presence_of :user_id, :body
  validates_length_of :body, :maximum => 130
  attr_accessible :body
  belongs_to :user, :counter_cache => true
  
  def self.get(page = 1)
    paginate(:page => page, :per_page => 20, :order => 'created_at desc', :include => :user)
  end
  
  def to_s
    self.body
  end
  
end
