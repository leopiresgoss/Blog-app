class UsersController < ApplicationController
  # before_action :authenticate_user!

  def index
    @current_user = current_user
    @users = User.all
  end

  def show
    @current_user = current_user
    @user = User.includes(:posts, :comments).find(params[:id].to_i)
  end
end
