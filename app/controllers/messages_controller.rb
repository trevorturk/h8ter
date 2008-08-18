class MessagesController < ApplicationController
  
  before_filter :login_required, :except => [:index]
  
  def index
    @messages = Message.get
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
