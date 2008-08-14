require 'test_helper'

class MessagesControllerTest < ActionController::TestCase

  def test_create
    login_as :quentin
    u = users(:quentin)
    assert_difference 'Message.count' do
      assert_difference 'u.messages_count' do
        post :create, :message => {:body => 'test'}
        u.reload
      end
    end
  end
  
  def test_create_required_login
    assert_no_difference 'Message.count' do
      post :create, :message => {:body => 'test'}
    end
    assert_redirected_to new_session_path
  end
  
end
