class MembersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])

    @comments = @user.comments.paginate( :page => params[:page], :per_page => 10)
  end
end
