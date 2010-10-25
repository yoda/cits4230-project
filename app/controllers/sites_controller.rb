class SitesController < ApplicationController
  
  before_filter :prepare_site, :only => [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only => [:new, :create]

  def index
    @page_title = 'All Sites'
    @sites = Site.all.paginate( :page => params[:page], :per_page => 10)
  end
  
  def new
    @page_title = 'Add a new site'
    @site = Site.new
  end
  
  def create
    @site = Site.new(params[:site])
    @site.owner = current_user if @site.self_authored?
    if @site.save
      redirect_to @site
    else
      render :action => "new"
    end
  end
  
  def show
    @page_title = 'Site'
    @stories = @site.stories.paginate(:page => params[:page], :per_page => 25)
  end
  
  protected
  
  def prepare_site
    @site = Site.find(params[:id])
  end
  
end
