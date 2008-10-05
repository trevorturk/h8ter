require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  
  def test_index_when_logged_in
    login_as :quentin
    get :index
    assert_response :success
  end
  
  def test_index_when_not_logged_in
    get :index
    assert_response :success
  end
  
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
  
  def test_create_with_too_many_chars
    login_as :quentin
    char = ("a".."z").to_a; char = Array.new(141, '').collect{char[rand(char.size)]}.join
    assert_no_difference 'Message.count' do
      post :create, :message => {:body => char}
    end
  end
  
  def test_should_show_message_when_logged_in
    login_as :quentin
    u = users(:quentin)
    m = u.messages.create(:body => 'foo')
    get :show, :id => m.id
    assert_response :success
  end
  
  def test_should_show_messages_when_not_logged_in
    u = users(:quentin)
    m = u.messages.create(:body => 'foo')
    get :show, :id => m.id
    assert_response :success
  end
  
  def test_should_get_rss_feed
    get :index, :format => 'rss'
    assert_response :success
    assert_template 'index', :format => 'rss'
  end
  
  def test_should_get_rss_feed_if_no_messages
    Message.destroy_all
    get :index, :format => 'rss'
    assert_response :success
    assert_template 'index', :format => 'rss'
  end
  
end
