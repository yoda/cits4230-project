class CommentsController < ApplicationController
  
  before_filter :prepare_story, :only => [:create]
  before_filter :authenticate_user!

  def create
    @page_title = "Add a comment"
    @comment      = @story.comments.build(params[:comment]) 
    @comment.user = current_user
    if @comment.save
      flash[:message] = "Sucessfully commented on the story"
    else
      flash[:message] = "Failure to comment on the story"
    end
    redirect_to [@story.site, @story]
  end

  protected

  def prepare_story
    @story = Story.find(params[:story_id])
  end

end
