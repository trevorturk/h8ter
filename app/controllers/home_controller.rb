class HomeController < ApplicationController
  
  def index
    if logged_in?
      @messages = Message.get(params[:page])
      render 'messages/index'
    else
      render 'home/index'
    end
  end
    
  def fail
    redirect_to '/500.html'
  end
  
  def exception
    raise 'exception test'
  end
    
end
