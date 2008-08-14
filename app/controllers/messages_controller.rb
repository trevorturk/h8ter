class MessagesController < ApplicationController
  
  def index
    @messages = Message.all(:limit => 20)
  end
  
  def create
    @message = current_user.messages.new(params[:message])
    if @message.save
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end
  
end
