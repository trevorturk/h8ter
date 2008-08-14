class MessagesController < ApplicationController
  
  def index
  end
  
  def create
    flash[:notice] = 'Hate FAIL.'
    render :action => 'messages/index'
  end
  
end
