require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  
  def test_that_message_is_limited_to_130_chars
    char = ("a".."z").to_a; char = Array.new(131, '').collect{char[rand(char.size)]}.join
    assert_no_difference 'Message.count' do
      m = Message.create(:body => char) {|m| m.user = users(:quentin)}
    end
  end
  
  # def test_that_message_with_more_than_130_chars_is_trimmed_before_save
  #   char = ("a".."z").to_a; char = Array.new(130, '').collect{char[rand(char.size)]}.join
  #   assert_difference 'Message.count' do
  #     m = Message.create(:body => char) {|m| m.user = users(:quentin)}
  #     assert m.body == char
  #   end
  # end
  
end
