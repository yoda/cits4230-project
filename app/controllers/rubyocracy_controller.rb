class RubyocracyController < ApplicationController

  def index
  end

  def trending
  end
  
  def hide_notice
    cookies[:notice_hidden] = "1"
    render :nothing => true
  end

end
