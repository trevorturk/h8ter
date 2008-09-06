module Authentication
  unless defined? CONSTANTS_DEFINED
    RE_LOGIN_OK     = /\A\w[\w\.\-_@]+\z/                     # ASCII, strict
    MSG_LOGIN_BAD   = "use only letters, numbers, and .-_@ please."
    RE_NAME_OK      = /\A[^[:cntrl:]\\<>\/&]*\z/              # Unicode, permissive
    MSG_NAME_BAD    = "avoid non-printing characters and \\&gt;&lt;&amp;/ please."
    RE_EMAIL_NAME   = '[\w\.%\+\-]+'                          # what you actually see in practice
    RE_DOMAIN_HEAD  = '(?:[A-Z0-9\-]+\.)+'
    RE_DOMAIN_TLD   = '(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum)'
    RE_EMAIL_OK     = /\A#{RE_EMAIL_NAME}@#{RE_DOMAIN_HEAD}#{RE_DOMAIN_TLD}\z/i
    MSG_EMAIL_BAD   = "should look like an email address."
    CONSTANTS_DEFINED = 'yup' # sorry for the C idiom
  end

  def self.included( recipient )
    recipient.extend( ModelClassMethods )
    recipient.class_eval do
      include ModelInstanceMethods
    end
  end

  module ModelClassMethods
    def secure_digest(*args)
      Digest::SHA1.hexdigest(args.flatten.join('--'))
    end
    def make_token
      secure_digest(Time.now, (1..10).map{ rand.to_s })
    end
  end # class methods

  module ModelInstanceMethods
  end # instance methods

end
