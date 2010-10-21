class StoriesController < ApplicationController

def index
  @stories = Story.ordered.paginate :page => params[:page], :include => :site, :per_page => 20
end

end