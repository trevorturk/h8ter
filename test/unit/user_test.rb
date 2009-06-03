require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  def test_should_create_user
    assert_difference 'User.count' do
      user = create_user
      assert !user.new_record?, "#{user.errors.full_messages.to_sentence}"
    end
  end
  
  def test_should_require_login
    assert_no_difference 'User.count' do
      u = create_user(:login => nil)
      assert u.errors.on(:login)
    end
  end

  def test_should_require_password
    assert_no_difference 'User.count' do
      u = create_user(:password => nil)
      assert u.errors.on(:password)
    end
  end

  def test_should_require_password_confirmation
    assert_no_difference 'User.count' do
      u = create_user(:password_confirmation => nil)
      assert u.errors.on(:password_confirmation)
    end
  end

  def test_should_require_email
    assert_no_difference 'User.count' do
      u = create_user(:email => nil)
      assert u.errors.on(:email)
    end
  end
  
  def test_should_require_login_to_be_15_chars_or_less
    assert_no_difference 'User.count' do
      u = create_user(:login => '1234567890123456')
      assert u.errors.on(:login)
    end
  end
  
  def test_should_require_login_to_be_alpha_numeric_with_underscores
    assert_no_difference 'User.count' do
      u = create_user(:login => '='); assert u.errors.on(:login)
      u = create_user(:login => '~'); assert u.errors.on(:login)
      u = create_user(:login => '!'); assert u.errors.on(:login)
      u = create_user(:login => '#'); assert u.errors.on(:login)
      u = create_user(:login => '.'); assert u.errors.on(:login)
      u = create_user(:login => '/'); assert u.errors.on(:login)
      u = create_user(:login => '-'); assert u.errors.on(:login)
      u = create_user(:login => '+'); assert u.errors.on(:login)
      u = create_user(:login => '|'); assert u.errors.on(:login)
      u = create_user(:login => ':'); assert u.errors.on(:login)
      u = create_user(:login => ')'); assert u.errors.on(:login)
      u = create_user(:login => '*'); assert u.errors.on(:login)
      u = create_user(:login => '&'); assert u.errors.on(:login)
      u = create_user(:login => '%'); assert u.errors.on(:login)      
      u = create_user(:login => '$'); assert u.errors.on(:login)
    end
  end
  
  def test_should_reserve_some_common_usernames
    assert_no_difference 'User.count' do
      u = create_user(:login => 'admin'); assert u.errors.on(:login)
      u = create_user(:login => 'test'); assert u.errors.on(:login)
      u = create_user(:login => 'help'); assert u.errors.on(:login)
    end
  end
  
  def test_should_allow_user_accounts_with_one_character
    assert_difference 'User.count' do
      u = create_user(:login => '_')
    end
  end

  def test_should_allow_user_accounts_with_one_character_password
    assert_difference 'User.count' do
      u = create_user(:password => '1', :password_confirmation => '1')
    end
  end

  def test_should_reset_password
    users(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal users(:quentin), User.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    users(:quentin).update_attributes(:login => 'quentin2')
    assert_equal users(:quentin), User.authenticate('quentin2', 'monkey')
  end

  def test_should_authenticate_user
    assert_equal users(:quentin), User.authenticate('quentin', 'monkey')
  end
  
  def test_should_authenticate_user_with_wrong_case_upper
    assert_equal users(:quentin), User.authenticate('Quentin', 'monkey')
  end
  
  def test_should_authenticate_user_with_wrong_case_lower
    assert_equal users(:QuentinCase), User.authenticate('quentincase', 'monkey')
  end

  def test_should_set_remember_token
    users(:quentin).remember_me
    assert_not_nil users(:quentin).remember_token
    assert_not_nil users(:quentin).remember_token_expires_at
  end

  def test_should_unset_remember_token
    users(:quentin).remember_me
    assert_not_nil users(:quentin).remember_token
    users(:quentin).forget_me
    assert_nil users(:quentin).remember_token
  end

  def test_should_remember_me_for_one_week
    time = 1.week.from_now.utc.change(:usec => 0)
    users(:quentin).remember_me_for 1.week
    assert_not_nil users(:quentin).remember_token
    assert_not_nil users(:quentin).remember_token_expires_at
    assert_equal users(:quentin).remember_token_expires_at.change(:usec => 0), time
  end

  def test_should_remember_me_until_one_week
    time = 1.week.from_now.utc.change(:usec => 0)
    users(:quentin).remember_me_until time
    assert_not_nil users(:quentin).remember_token
    assert_not_nil users(:quentin).remember_token_expires_at
    assert_equal users(:quentin).remember_token_expires_at.change(:usec => 0), time
  end

  def test_should_remember_me_default_two_weeks
    time = 2.weeks.from_now.utc.change(:usec => 0)
    users(:quentin).remember_me
    assert_not_nil users(:quentin).remember_token
    assert_not_nil users(:quentin).remember_token_expires_at
    assert_equal users(:quentin).remember_token_expires_at.change(:usec => 0), time
  end
    
  def test_to_s
    assert_equal users(:quentin).to_s, users(:quentin).login
  end

protected
  def create_user(options = {})
    User.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
  end
end
