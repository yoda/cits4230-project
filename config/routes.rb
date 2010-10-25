ActionController::Routing::Routes.draw do |map|
  map.devise_for :users
  
  map.hide_notice 'hide-notice', :controller => 'rubyocracy', :action => 'hide_notice'
  
  map.resources :sites do |site|
    site.resources :stories do |story|
      story.resources :comments
    end
  end
  
  map.like_site_story 'sites/:site_id/stories/:id/likes/:like_type', :controller => 'stories', :action => 'like', :conditions => {:method => :post}
  map.favourite_site_story 'sites/:site_id/stories/:id/favourites/:favourite_type', :controller => 'stories', :action => 'favourite', :conditions => {:method => :post}

  map.resources :members, :only => :show
  map.list_comments_by_user 'members/:id/comments', :controller => 'members', :action => 'list_comments_by_user', :conditions => {:method => :get}
  map.list_sites_by_user 'members/:id/sites', :controller => 'members', :action => 'list_sites_by_user', :conditions => {:method => :get}
  map.list_favorites_by_user 'members/:id/favorites', :controller => 'members', :action => 'list_favorites_by_user', :conditions => {:method => :get}


  map.catagorized 'catagories/:id/', :controller => 'rubyocracy', :action => 'categorized', :conditions => {:method => :get }
  
  map.root :controller => 'rubyocracy', :action => 'index'
end
