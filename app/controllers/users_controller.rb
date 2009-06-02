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
    @user.register! if @user && @user.valid?
    success = @user && @user.valid?
    if success && @user.errors.empty?
      self.current_user = @user
      redirect_back_or_default('/')
      # flash[:notice] = "Welcome. We're sending you an activation code in order to verify your email address."
    else
      flash[:error]  = "We couldn't set up that account, sorry. Please try again, or contact an admin."
      render :action => 'new'
    end
  end

  def activate
    logout_keeping_session!
    @user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && @user && !@user.active?
      @user.activate!
      self.current_user = @user
      flash[:notice] = "Signup complete!"
      redirect_back_or_default('/')
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing. Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find that activation code. Please check your email, or try to log in."
      redirect_back_or_default('/')
    end
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    @user.update_attributes(params[:user])
    if @user.save
      flash[:notice] = "Settings saved!"
      redirect_to settings_path
    else
      render :action => "edit"
    end
  end
  
end
