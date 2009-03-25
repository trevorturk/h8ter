class UserMailer < ActionMailer::Base

  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
    @body  = "#{CONFIG['site_url']}/activate/#{user.activation_code}"
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated'
    @body  = CONFIG['site_url']
  end
  
protected
  
  def setup_email(user)
    @recipients  = "#{user.email}"
    @from        = "#{CONFIG['site_name']} <#{CONFIG['site_email']}>"
    @subject     = "[#{CONFIG['site_name']}] "
    @sent_on     = Time.now
    @body = user
  end
  
end
