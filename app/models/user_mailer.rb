class UserMailer < ActionMailer::Base

  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
    @body  = "#{SITE_URL}/activate/#{user.activation_code}"
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated'
    @body  = SITE_URL
  end
  
protected
  
  def setup_email(user)
    @recipients  = "#{user.email}"
    @from        = SITE_EMAIL
    @subject     = "[#{SITE_NAME}] "
    @sent_on     = Time.now
    @body = user
  end
  
end
