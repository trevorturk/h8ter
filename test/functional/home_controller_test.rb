require 'test_helper'

class HomeControllerTest < ActionController::TestCase
    
  test "should fail/whale" do
    get :fail
    assert_redirected_to '/500.html'
  end
    
end
