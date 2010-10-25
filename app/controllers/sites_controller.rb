class SitesController < ApplicationController
  
  before_filter :prepare_site, :only => [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only => [:new, :create]

  def index
    @sites = Site.all.paginate( :page => params[:page], :per_page => 10)
  end
  
  def new
    @site = Site.new
  end
  
  def create
    @site = Site.new(params[:site])
    @site.owner_id = current_user
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
