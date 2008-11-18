load 'deploy' if respond_to?(:namespace) # cap2 differentiator

set :repository, 'git://github.com/trevorturk/h8ter.git'
set :scm, :git
set :deploy_via, :copy
set :git_shallow_clone, 1
set :branch, 'master'

set :application, 'h8ter'
set :deploy_to, '/home/h8ter'

role :app, "000.00.00.000"
role :web, "000.00.00.000"
role :db,  "000.00.00.000", :primary => true

before  'deploy:update_code', 'deploy:web:disable'
after   'deploy:update_code', 'deploy:config_database'
after   'deploy:restart', 'deploy:cleanup'
after   'deploy:restart', 'deploy:web:enable'

namespace :deploy do
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
  task :config_database do
    put(File.read('config/database.yml'), "#{release_path}/config/database.yml", :mode => 0444)
    # For security consider uploading a production-only database.yml to your server and using this instead:
    # run "cp #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end