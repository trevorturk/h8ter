class NoWWW
  def initialize(app)
    @app = app
  end
  
  def call(env)
    if host_with_www = env['HTTP_HOST'].match(/(^www.)(.*)/)
      [301, { 'Location' => host_with_www[2] }, ['Redirecting...']]
    else
      @app.call(env)
    end
  end
  
end
