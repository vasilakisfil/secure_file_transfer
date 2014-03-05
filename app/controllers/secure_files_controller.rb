class SecureFilesController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
    @secure_file = current_user.secure_files.build
  end

  def create
    @secure_file = current_user.secure_files.build(secure_file_params)
    if @secure_file.save
      flash[:success] = "File was uploaded!"
      redirect_to home_path
    else
      flash[:failure] = "File failed to upload"
      redirect_to home_path
    end
  end

  def show
    @user = current_user
  end

  def index
    @user = current_user
  end

  def edit
    @user = current_user
  end



  private

    # Before filters
    def secure_file_params
      params.require(:secure_file).permit(:description, :name)
    end

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
