class RubyocracyController < ApplicationController

  def index
    @page_title = 'Welcome to Rubyocracy'
    @stories = Story.ordered.paginate :page => params[:page], :include => [:site, :categories], :per_page => 20
    respond_to do |format|  
      format.html { render 'stories/index' }
      format.xml  { render :xml => @stories }  
      format.rss  { render :layout => false }  
    end  
  end

  def trending
    @page_title = 'Trending Stories'
    render 'stories/trending_stories'
  end

  def hide_notice
    cookies[:notice_hidden] = "1"
    render :nothing => true
  end

  def categorized
    @stories = Story.tagged_with(params[:id]).paginate :page => params[:page], :include => [:site, :categories], :per_page => 20
  end

end
