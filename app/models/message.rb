class Message < ActiveRecord::Base
  
  validates_presence_of :user_id, :body
  
  belongs_to :user, :counter_cache => true
  
  def to_s
    self.body
  end
  
end
