require 'test_helper'

class UserShowTest < ActionController::IntegrationTest

  def test_show_user
    get '/quentin/'
    assert_response :success
    assert_template 'users/show'
    # TODO 
    # assert_raises ActiveRecord::RecordNotFound do
    #   get '/not_a_user/'
    # end
  end
end