class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:succes] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end


  private

    def user_params
      params.require(:user).permit(:email, :name)
    end

    # Before filters

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to login_path, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
