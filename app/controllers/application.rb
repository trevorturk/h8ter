class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  filter_parameter_logging :password
  include AuthenticatedSystem
  
  before_filter :set_locale
  
  def set_locale
    I18n.locale = 'h8ter'
    I18n.populate { require "lib/locale/h8ter.rb" }
  end
  
end
