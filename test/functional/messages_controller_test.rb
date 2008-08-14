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
  
end
