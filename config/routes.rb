ActionController::Routing::Routes.draw do |map|
  map.devise_for :users
  
  map.hide_notice 'hide-notice', :controller => 'rubyocracy', :action => 'hide_notice'
  
  map.resources :sites do |site|
    site.resources :stories do |story|
      story.resources :comments
    end
  end

  
  map.root :controller => 'rubyocracy', :action => 'index'
end
