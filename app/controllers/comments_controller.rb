class CommentsController < ApplicationController
  
  before_filter :prepare_story, :only => [:create]
  before_filter :authenticate_user!

  def new
  end

  def create
    @comment = @story.comments.create(params[:comment]) 
    @comment.user = current_user
    if @comment.save
      flash[:message] = "Sucessfully commented on the story"
    else
      flash[:message] = "Failure to comment on the story"
    end
    render 'stories/show'
  end

  protected

  def prepare_story
    @story = Story.find(params[:story_id])
  end

end
