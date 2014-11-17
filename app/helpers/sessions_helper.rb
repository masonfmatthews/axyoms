module SessionsHelper

  def login(user)
    session[:user_id] = user.id
  end

  def set_login_forwarding
    session[:forwarding_url] = request.url if request.get?
  end

  def get_login_forwarding
    session[:forwarding_url]
  end

  def logout
    session.delete(:user_id)
    session.delete(:forwarding_url)
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
end
