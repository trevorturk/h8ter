class ApplicationController < ActionController::Base

  helper :all
  filter_parameter_logging :password
  protect_from_forgery
  
  include AuthenticatedSystem
  
end
