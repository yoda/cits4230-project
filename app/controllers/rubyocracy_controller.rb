class RubyocracyController < ApplicationController

  def index
    @stories = Story.ordered.paginate :page => params[:page], :include => :site, :per_page => 20
    render 'stories/index'
  end

  def trending
    render 'stories/trending_stories'
  end
  
  def hide_notice
    cookies[:notice_hidden] = "1"
    render :nothing => true
  end

end
