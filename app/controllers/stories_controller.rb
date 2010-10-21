class StoriesController < ApplicationController

def index
  @stories = Story.ordered.paginate :page => params[:page], :include => :site, :per_page => 20
end

def show
  @story = Story.find(params[:id])
  @story_comments = @story.comments.paginate( :page => params[:page], :per_page => 10)
end
end
