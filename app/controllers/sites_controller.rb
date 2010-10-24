class SitesController < ApplicationController
  
  before_filter :prepare_site, :only => [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only => [:new, :create]
  
  def new
    @site = Site.new
  end
  
  def create
    @site = Site.new(params[:site])
    if @site.save
      @site.update_feed!
      redirect_to @site
    else
      render :action => "new"
    end
  end
  
  def show
  end
  
  protected
  
  def prepare_site
    @site = Site.find(params[:id])
  end
  
end
