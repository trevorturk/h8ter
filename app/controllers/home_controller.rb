class HomeController < ApplicationController
  
  def index
    if logged_in?
      @messages = Message.all(:limit => 20)
      render :template => 'messages/index'
    else
      render :tempate => 'home/index'
    end
  end
    
end
