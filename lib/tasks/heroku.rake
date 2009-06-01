namespace :heroku do
  desc "Read config/config.yml and set production vars in Heroku ENV"
  task :config do
     CONFIG = YAML.load_file('config/config.yml')['production'] rescue {}
     command = "heroku config:add"
     CONFIG.each {|key, val| command << " #{key}=#{val} " }
     system command  
  end
end