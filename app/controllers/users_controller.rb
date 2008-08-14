class UsersController < ApplicationController
  
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  # before_filter :find_user, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :login_required, :except => [:show, :new, :create, :activate]
  
  def show
    @user = User.find_by_login(params[:login])
    raise ActiveRecord::RecordNotFound unless @user
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
      flash[:notice] = "Thanks for signing up! We're sending you an email with an activation code. You'll need to activate you account in order to log in again later."
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
    if logged_in?
      @user = current_user
    else
      flash[:error] = "Please log in."
      redirect_to '/login'
    end
  end

  # def suspend
  #   @user.suspend! 
  #   redirect_to users_path
  # end
  # 
  # def unsuspend
  #   @user.unsuspend! 
  #   redirect_to users_path
  # end
  # 
  # def destroy
  #   @user.delete!
  #   redirect_to users_path
  # end
  # 
  # def purge
  #   @user.destroy
  #   redirect_to users_path
  # end
  
protected
  def find_user
    @user = User.find(params[:id])
  end
end
