class MessagesController < ApplicationController
  
  before_filter :login_required, :except => [:index, :show]
  
  def index
    @messages = Message.get(params[:page])
  end
  
  def create
    @message = current_user.messages.new(params[:message])
    if @message.save
      redirect_to :action => "index"
    else
      flash[:error] = 'There was a problem sending this message. Perhaps it is blank, or more than 140 characters?'
      render :action => "new"
    end
  end
  
  def show
    @message = Message.find(params[:id])
  end
  
end
