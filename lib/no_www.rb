class NoWWW
  def initialize(app)
    @app = app
  end
  
  def call(env)
    if env['HTTP_HOST'] =~ /^www\./i
      [301, { 'Location' => Rack::Request.new(env).url.sub(/www\./i, '') }, ['Redirecting...']]
    else
      @app.call(env)
    end
  end
  
end
