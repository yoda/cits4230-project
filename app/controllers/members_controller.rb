class MembersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_user

  def show
    @comments           = @user.comments.paginate( :page => params[:page], :per_page => 10)
    @recent_favorites   = @user.favorites.all(:order => 'created_at DESC', :limit => 10).map(&:favorable).compact
    @recent_liked_items = @user.likes.all(:order => 'created_at DESC', :limit => 10).map(&:likeable).compact
    @num_likes          = @user.likes.count :all, :conditions => {:value => 1}
    @num_dislikes       = @user.likes.count :all, :conditions => {:value => -1}
  end

  def list_comments_by_user
    @comments = @user.comments.paginate( :page => params[:page], :per_page => 10)
    render 'comments'
  end

  def list_sites_by_user
    @sites = Site.paginate(:page => params[:page], :per_page => 10, :conditions => {:owner_id => @user.id})
    render 'sites'
  end

  def list_favorites_by_user
    @favorites = @user.favorites.paginate(:page => params[:page], :per_page => 10)
    render 'favorites'
  end

  protected

  def load_user
    @user = User.find(params[:id])
  end

end
