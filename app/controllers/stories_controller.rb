class StoriesController < ApplicationController

  before_filter :authenticate_user!, :only => [:like, :favourite]
  
  before_filter :prepare_story

  def show
    @page_title = "Viewing Story: #{@story.title}"
    @story_comments = @story.comments.paginate( :page => params[:page], :per_page => 10)
  end
  
  def like
    @story.update_liked! current_user, params[:like_type]
    redirect_to :back
  end
  
  def favourite
    type = params[:favourite_type]
    if type == "add"
      current_user.has_favorite @story
    elsif type == "remove"
      current_user.has_no_favorite @story
    end
    redirect_to :back
  end
  
  protected
  
  def prepare_site
    @site = Site.find(params[:site_id])
  end
  
  def prepare_story
    prepare_site
    @story = @site.stories.find(params[:id], :include => :categories)
  end

end
