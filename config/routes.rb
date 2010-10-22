ActionController::Routing::Routes.draw do |map|
  map.devise_for :users
  
  map.hide_notice 'hide-notice', :controller => 'rubyocracy', :action => 'hide_notice'
  
  map.resources :sites do |site|
    site.resources :stories
  end
  
  map.like_site_story 'sites/:site_id/stories/:id/likes/:like_type', :controller => 'stories', :action => 'like', :conditions => {:method => :post}
  map.favourite_site_story 'sites/:site_id/stories/:id/favourites/:favourite_type', :controller => 'stories', :action => 'favourite', :conditions => {:method => :post}

  map.resources :stories
  
  map.root :controller => 'rubyocracy', :action => 'index'
end
