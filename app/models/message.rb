class Message < ActiveRecord::Base
  
  validates_presence_of :user_id, :body
  validates_length_of :body, :maximum => 140
  attr_accessible :body
  belongs_to :user, :counter_cache => true
  
  def self.get
    all(:limit => 20, :order => 'created_at desc', :include => :user)
  end
  
  def to_s
    self.body
  end
  
end
