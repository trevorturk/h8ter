class HomeController < ApplicationController
  
  def index
    if logged_in?
      @messages = Message.get
      render :template => 'messages/index'
    else
      render :tempate => 'home/index'
    end
  end
    
end
