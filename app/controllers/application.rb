class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  filter_parameter_logging :password
  include AuthenticatedSystem
  Time.zone = 'Central Time (US & Canada)'
  
  helper_method :current_action, :current_controller
  
  def current_action
    request.path_parameters['action']
  end
  
  def current_controller
    request.path_parameters['controller']
  end
  
end
