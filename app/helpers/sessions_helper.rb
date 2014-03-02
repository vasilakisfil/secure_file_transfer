module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    current_user.update_attribute(
      :remember_token,
      User.encrypt(User.new_remember_token)
    )
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.encrypt(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
    puts "aaaaaaaaaaaaaaaaaa #{request.url}"
  end

  module ExternalAuthAPI
    # this method should be overrided by rails app
    def self.authenticate_user(username, password)
      #should call here the RADIUS helper instead
      success = false
      if username == 'username' && password == 'password'
        success = true
      elsif username == 'username1' && password == 'password'
        success = true
      elsif username == 'username2' && password == 'password'
        success = true
      elsif username == 'username3' && password == 'password'
        success = true
      elsif username == 'username4' && password == 'password'
        success = true
      elsif username == 'test' && password == 'test'
        success = true
      elsif username == 'test1' && password == 'test1'
        success = true
      end
    end
  end
end