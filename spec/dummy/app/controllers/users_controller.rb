class UsersController < ApplicationController
  def index
    authorize!
  end
  
  def show
    @user = User.find(params[:id])
    authorize! 
  end
end
