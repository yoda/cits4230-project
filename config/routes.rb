ActionController::Routing::Routes.draw do |map|
  map.devise_for :users
  map.root :controller => 'rubyocracy', :action => 'index'
  
  map.hide_notice 'hide-notice', :controller => 'rubyocracy', :action => 'hide_notice'
  
  map.resources :sites do |site|
    site.resources :news_records, :as => 'stories'
  end
  
end
