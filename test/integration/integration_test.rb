require 'test_helper'

class IntegrationTest < ActionController::IntegrationTest
  fixtures :all

  def test_show_user
    get '/quentin/'
    assert_response :success
    assert_template 'users/show'
    # TODO 
    # assert_raises ActiveRecord::RecordNotFound do
    #   get '/not_a_user/'
    # end
  end
  
  def test_should_get_settings_page
    get '/settings'
    assert_redirected_to '/login'
    post '/session', :email => 'quentin', :password => 'monkey'
    assert_response :success
    get '/settings'
    # TODO 
    # assert_template 'users/edit'
  end
end