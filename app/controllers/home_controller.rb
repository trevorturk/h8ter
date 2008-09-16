class HomeController < ApplicationController
  
  def index
    if logged_in?
      @messages = Message.get(params[:page])
      render :template => 'messages/index'
    else
      render :tempate => 'home/index'
    end
  end
  
  def fail
    redirect_to '/500.html'
  end
    
end
