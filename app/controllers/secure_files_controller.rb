class SecureFilesController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user

  def new
    @secure_file = current_user.secure_files.build
  end

  def create
    @secure_file = current_user.secure_files.build(secure_file_params)
    if @secure_file.save
      flash[:success] = "File was uploaded!"
      names = secure_file_params[:shared_to]
      names = names.split
      names.each do |name|
        user = User.find_by(username: name)
        user.secure_files.create(
          name: secure_file_params[:name],
          description: secure_file_params[:description],
          seen: false,
          shared_by: current_user.username
        )
      end
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

  def destroy
    if @secure_file
      @secure_file.destroy
      flash[:notice] = "Your file was deleted successfully."
    else
      redirect_to home_path
      flash[:notice] = "Patience: you only need to press delete once"
    end
    redirect_to home_path
  end



  private

    # Before filters
    def secure_file_params
      params.require(:secure_file).permit(:shared_to, :description, :name)
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to login_path, notice: "Please sign in."
      end
    end

    def correct_user
      @secure_file = current_user.secure_files.find_by(id: params[:id])
      #redirect_to(root_path) if @secure_file.nil?
    end
end
