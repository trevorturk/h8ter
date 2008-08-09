class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  filter_parameter_logging :password
  include AuthenticatedSystem
  I18n.populate { require "lib/locale/en-US.rb" }  
end
