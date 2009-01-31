require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  
  def test_that_message_is_limited_to_115_chars
    char = ("a".."z").to_a; char = Array.new(116, '').collect{char[rand(char.size)]}.join
    assert_no_difference 'Message.count' do
      m = Message.create(:body => char) {|m| m.user = users(:quentin)}
    end
  end
  
  def test_that_message_must_be_unique_scoped_to_user
    Message.create(:body => 'dup') {|m| m.user = users(:quentin)}
    assert_no_difference 'Message.count' do
      Message.create(:body => 'dup') {|m| m.user = users(:quentin)}
    end
  end
  
  # def test_that_message_with_more_than_115_chars_is_trimmed_before_save
  #   char = ("a".."z").to_a; char = Array.new(115, '').collect{char[rand(char.size)]}.join
  #   assert_difference 'Message.count' do
  #     m = Message.create(:body => char) {|m| m.user = users(:quentin)}
  #     assert m.body == char
  #   end
  # end
  
end
