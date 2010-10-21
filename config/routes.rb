ActionController::Routing::Routes.draw do |map|
  map.devise_for :users
  
  map.hide_notice 'hide-notice', :controller => 'rubyocracy', :action => 'hide_notice'
  
  map.resources :sites do |site|
    site.resources :stories
  end

  map.resources :stories
  
  map.root :controller => 'rubyocracy', :action => 'index'
end
