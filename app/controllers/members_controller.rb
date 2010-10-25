class MembersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_user

  def show
    @comments = @user.comments.paginate( :page => params[:page], :per_page => 10)
    @recent_favorites = (@user.favorites.all(:order => ':created_at DESC', :limit => 10).map{ | entry | entry.favorable_type.classify.constantize.find(entry.favorable_id)})
    @recent_liked_items = (@user.likes.all(:order => ':created_at DESC', :limit => 10).map{ | entry | entry.value == 1 ? entry.likeable_type.classify.constantize.find(entry.likeable_id) : nil}).compact 
    @num_likes = (@user.likes.all.map { | entry | entry.value == 1 ? 1 : nil }).compact.sum
    @num_dislikes = (@user.likes.all.map { | entry | entry.value == -1 ? 1 : nil }).compact.sum
  end

  def list_comments_by_user
    @comments = @user.comments.paginate( :page => params[:page], :per_page => 10)
    render 'comments'
  end

  def list_sites_by_user
    temp = Site.all.collect { | item| item.owner_id == @user.id ? nil : item }
    temp.compact!
    @sites = temp.paginate( :page => params[:page], :per_page => 10)
    render 'sites'
  end

  def list_favorites_by_user
    @favorites = (@user.favorites.map { | entry | entry.favorable_type.classify.constantize.find(entry.favorable_id) }).paginate( :page => params[:page], :per_page => 10)
    render 'favorites'
  end

  protected

  def load_user
    @user = User.find(params[:id])
  end

end
