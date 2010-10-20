class SitesController < ApplicationController
  
  before_filter :prepare_site, :only => [:show, :edit, :update, :destroy]
  
  def new
    @site = Site.new
  end
  
  def create
    @site = Site.new(params[:site])
    if @site.save
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
