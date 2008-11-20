require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  
  test "should defer test" do
    defer
  end
  
  test "should fail" do
    get :fail
    assert_redirected_to '/500.html'
  end
    
end
