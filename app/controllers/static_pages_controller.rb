class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @user = current_user
      @secure_file = current_user.secure_files.build
    end
  end


end
