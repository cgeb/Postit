class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_user, only: [:show]
  before_action :correct_user, only: [:edit, :update]

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:user_name, :password))

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Postit!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your profile has been updated."
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    if current_user != @user
      flash[:error] = "You're not allowed to do that."
      redirect_to root_path
    end
  end
end