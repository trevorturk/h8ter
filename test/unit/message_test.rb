require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  
  def test_that_message_is_limited_to_140_chars
    char = ("a".."z").to_a; char = Array.new(141, '').collect{char[rand(char.size)]}.join
    assert_no_difference 'Message.count' do
      m = Message.create(:body => char) {|m| m.user = users(:quentin)}
    end
  end
    
  def test_no_twitter_post_after_message_creation_if_user_and_pass_not_provided
    Twitter.expects(:post).never
    Message.create(:body => 'post!') {|m| m.user = users(:quentin)}
  end
  
  # def test_that_message_with_more_than_140_chars_is_trimmed_before_save
  #   char = ("a".."z").to_a; char = Array.new(140, '').collect{char[rand(char.size)]}.join
  #   assert_difference 'Message.count' do
  #     m = Message.create(:body => char) {|m| m.user = users(:quentin)}
  #     assert m.body == char
  #   end
  # end
  
end
