class SessionsController < ApplicationController
  def new
    request.headers.each do |key, value|
      puts "#{key} --- #{value}"
    end
    request.env.each do |key, value|
      puts "#{key} --- #{value}"
    end
    if !request.env['SSL_CLIENT_CERT'].blank?
      ca = OpenSSL::X509::Certificate.new(File.read('cacert.pem'))
      lic = OpenSSL::X509::Certificate.new(request.env['SSL_CLIENT_CERT']) if !request.env['SSL_CLIENT_CERT'].blank?
      if lic.verify( ca.public_key )
        @ssl = "Logging in with valid ssl client cert, no need for 2FA"
        session[:two_factor_auth] = false
        @otp_disabled = true
      else
        @ssl = "Invalid ssl client cert, falling back to 2FA"
        session[:two_factor_auth] = true
        @otp_disabled = false
      end
    else
      @ssl = "No ssl client cert, falling back to 2FA"
        session[:two_factor_auth] = true
        @otp_disabled = false
    end

  end

  def create
    valid_credits = validate_credentials(
      params[:session][:username],
      params[:session][:password]
    )
    request.headers.each do |key, value|
      puts "#{key} --- #{value}"
    end
    if session[:two_factor_auth]
      @otp_auth = true
    else
      @otp_auth = false
    end
    if valid_credits
      user = User.find_by(username: params[:session][:username])
      if !user
        if @otp_auth
          flash[:otp_credentials] = 'Cannot validate you with 2FA for the first time'
          render 'new'
        else
          user = create_new_user(params[:session][:username])
          flash[:login] = "Welcome new user #{user.username}"
          sign_in user
          redirect_back_or home_path
        end
      else
        if validate_otp(params[:session][:two_factor_authentication], user)
          flash[:login] = "Welcome user #{params[:session][:username]}"
          sign_in user
          redirect_back_or home_path
        else
          flash[:otp_credentials] = "Wrong 2FA validation"
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

  def destroy
    sign_out
    redirect_to root_path
  end


  private
    def validate_otp(otp, user)
      if !(otp.to_i == user.otp_code) && !otp.blank?
        false
      else
        true
      end
    end

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
