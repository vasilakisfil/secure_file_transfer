class SessionsController < ApplicationController
  def new
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
        redirect_to user
      else
        flash[:login] = "Welcome user #{params[:session][:username]}"
        if user.save
          redirect_to user
        else
          flash[:error] = 'Could not create user'
          render 'new'
        end
      end
    else
      flash[:wrong_credentials] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def show

  end

  def delete
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
