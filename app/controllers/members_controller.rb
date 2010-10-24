class MembersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_user

  def show
    @comments = @user.comments.paginate( :page => params[:page], :per_page => 10)
  end

  def list_comments_by_user
    @comments = @user.comments.paginate( :page => params[:page], :per_page => 10)
    render 'comments'
  end

  def list_sites_by_user
    @sites = @user.sites.paginate( :page => params[:page], :per_page => 10)
    render 'sites'
  end

  def list_favorites_by_user
    @sites = @user.favorites.paginate( :page => params[:page], :per_page => 10)
    render 'favorites'
  end

  protected

  def load_user
    @user = User.find(params[:id])
  end

end
