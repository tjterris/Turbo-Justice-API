class UserController < ApplicationController
# Get all Flanker games of given user
  def index
    @user = User.find(params[:id])
    @flankers = @user.flankers.all
    render json: @user.flankers,
    status: :ok
  end
# Show user information for given user
  def show
    @user = User.find(params[:id])
    render json: @user,
    status: :ok
  end
end
