class UsersController < ApplicationController
  
  before_filter :login_required, :except => [:show, :new, :create, :activate]
  
  def show
    @user = User.find_by_login(params[:login])
    raise ActiveRecord::RecordNotFound unless @user
    @messages = @user.messages.get(params[:page])
  end
  
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    if @user && @user.valid? && @user.save
      self.current_user = @user
      redirect_back_or_default('/')
    else
      flash[:error]  = "We couldn't set up that account, sorry. Please try again, or contact an admin."
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    @user.update_attributes(params[:user])
    if @user.save
      flash[:notice] = "Settings saved"
      redirect_to settings_path
    else
      render :action => "edit"
    end
  end
  
end
