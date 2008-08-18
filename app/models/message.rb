class Message < ActiveRecord::Base
  
  validates_presence_of :user_id, :body
  
  belongs_to :user, :counter_cache => true
  
  def self.get
    all(:limit => 20, :order => 'created_at desc', :include => :user)
  end
  
  def to_s
    self.body
  end
  
end
