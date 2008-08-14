class Message < ActiveRecord::Base
  
  validates_presence_of :user_id, :body
  
  belongs_to :user, :counter_cache => true
  
end
