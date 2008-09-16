ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => 'home', :action => 'index'
  
  map.resources :messages
  map.resource :session
  map.resources :users, :member => {:suspend => :put, :unsuspend => :put, :purge => :delete}
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  
  map.fail '/fail', :controller => 'home', :action => 'fail'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.settings '/settings', :controller => 'users', :action => 'edit'
  
  map.profile ':login', :controller => 'users', :action => 'show'
  
end
