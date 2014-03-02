class SessionsController < ApplicationController
  def new
    if signed_in?
      @user = current_user
    end
  end

  def create
    valid_credits = validate_credentials(
      params[:session][:username],
      params[:session][:password]
    )

    if valid_credits
      user = User.find_by(username: params[:session][:username])
      if !user
        user = create_new_user(params[:session][:username])
        flash[:login] = "Welcome new user #{user.username}"
        sign_in user
        redirect_back_or user
      else
        flash[:login] = "Welcome user #{params[:session][:username]}"
        sign_in user
        redirect_back_or user
      end
    else
      flash[:wrong_credentials] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def show

  end

  def destroy
    sign_out
    redirect_to root_path
  end


  private
    def validate_credentials(username, password)
      SessionsHelper::ExternalAuthAPI.authenticate_user(
        username,
        password,
      )
    end

    def create_new_user(username)
        user = User.new(
          username:username
        )
        user.save
        return user
    end
end
