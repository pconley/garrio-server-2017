class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  #protect_from_forgery with: #:exception
  
  before_filter :authenticate_user
    
  def authenticate_user
    return true if current_user
    #puts "*** user authentication failed"
    redirect_to root_url, notice: "Login Required."
  end
  
  def authenticate_admin
    return true if current_user && current_user.is_admin?
    #puts "*** admin authentication failed"
    redirect_to root_url, notice: "Admin Required."
  end
  

  
  helper_method :current_user  
  def current_user
    #puts "---> #{session.keys} params = #{params}"    
    @current_user ||= User.find_by_id(session[:user_id])
  end
  
  def set_current_user(user)  
    if user && user.is_a?(User)
      session[:user_id] = user.id
    else
      clear_current_user()
    end
  end

  def clear_current_user()
    session[:user_id] = nil 
  end

end
