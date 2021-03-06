class SitesController < ApplicationController
  
  before_filter :prepare_site, :only => [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only => [:new, :create]

  def index
    @page_title = 'All Sites'
    @sites = Site.paginate( :page => params[:page], :per_page => 10)
  end
  
  def new
    @page_title = 'Add a new site'
    @site = Site.new
  end
  
  def create
    @page_title = 'Add a new site'
    @site = Site.new(params[:site])
    @site.owner = current_user if @site.self_authored?
    if @site.save
      redirect_to @site
    else
      render :action => "new"
    end
  end
  
  def show
    @page_title = "Viewing Site: #{@site.name}"
    @stories = @site.stories.ordered.paginate(:page => params[:page], :per_page => 25)
  end
  
  protected
  
  def prepare_site
    @site = Site.find(params[:id])
  end
  
end
