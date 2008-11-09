class MessagesController < ApplicationController
  
  before_filter :login_required, :except => [:index, :show]
  
  def index
    @messages = Message.get(params[:page])
  end
  
  def create
    @message = current_user.messages.new(params[:message])
    if @message.save
      if TWITTER_USER && TWITTER_PASS
        Twitter.post('/statuses/update.json', :query => {:status => @message.user + ' hates ' + @message.body, :source => TWITTER_SOURCE})
      end
      redirect_to :action => "index"
    else
      flash[:error] = "There was a problem sending this message. It can't be blank or more than 130 characters."
      render :action => "new"
    end
  end
  
  def show
    @message = Message.find(params[:id])
  end
  
end
