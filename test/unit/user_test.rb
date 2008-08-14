require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  def test_should_create_user
    assert_difference 'User.count' do
      user = create_user
      assert !user.new_record?, "#{user.errors.full_messages.to_sentence}"
    end
  end
  
  def test_should_initialize_activation_code_upon_creation
    user = create_user
    user.reload
    assert_not_nil user.activation_code
  end

  def test_should_create_and_start_in_pending_state
    user = create_user
    user.reload
    assert user.pending?
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

  def test_should_register_passive_user
    user = create_user(:password => nil, :password_confirmation => nil)
    assert user.passive?
    user.update_attributes(:password => 'new password', :password_confirmation => 'new password')
    user.register!
    assert user.pending?
  end

  def test_should_suspend_user
    users(:quentin).suspend!
    assert users(:quentin).suspended?
  end

  def test_suspended_user_should_not_authenticate
    users(:quentin).suspend!
    assert_not_equal users(:quentin), User.authenticate('quentin', 'test')
  end

  def test_should_unsuspend_user_to_active_state
    users(:quentin).suspend!
    assert users(:quentin).suspended?
    users(:quentin).unsuspend!
    assert users(:quentin).active?
  end

  def test_should_unsuspend_user_with_nil_activation_code_and_activated_at_to_passive_state
    users(:quentin).suspend!
    User.update_all :activation_code => nil, :activated_at => nil
    assert users(:quentin).suspended?
    users(:quentin).reload.unsuspend!
    assert users(:quentin).passive?
  end

  def test_should_unsuspend_user_with_activation_code_and_nil_activated_at_to_pending_state
    users(:quentin).suspend!
    User.update_all :activation_code => 'foo-bar', :activated_at => nil
    assert users(:quentin).suspended?
    users(:quentin).reload.unsuspend!
    assert users(:quentin).pending?
  end

  def test_should_delete_user
    assert_nil users(:quentin).deleted_at
    users(:quentin).delete!
    assert_not_nil users(:quentin).deleted_at
    assert users(:quentin).deleted?
  end
  
  def test_should_not_allow_email_change
    u = users(:quentin)
    u.update_attribute(:email, 'readonly@example.com')
    u.reload
    assert_not_equal u.email, 'readonly@example.com'
  end
  
  def test_to_s
    assert_equal users(:quentin).to_s, users(:quentin).login
  end

protected
  def create_user(options = {})
    record = User.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
    record.register! if record.valid?
    record
  end
end
