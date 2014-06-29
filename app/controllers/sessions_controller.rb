class SessionsController < ApplicationController
    
  skip_before_filter :authenticate_user, only: [:new, :create, :callback, :google, :options]  
  
  def new
    puts "SessionController: new"
    @user = new_user
  end
  
  def new_user
    user = User.new()
    if cookies[:name]
      user.name = cookies[:name]
      user.remember_me = true
    end
    return user
  end
    
  def options
    head :ok
    #render :nothing => true, :status => 200
  end
    
  def create
    puts "\n\nSessions Controller: create. params = #{params}"
    email = params["email"] || params[:user][:email]
    pswd = params["password"] || params[:user][:password]
    user = User.find_by_name(email) || User.find_by_email(email)
    # puts "*** user = #{user} activated=#{user.try(:activated)}"
    if user && user.activated && user.authenticate(pswd)
      # puts "*** authentication worked"
      user.login()
      set_current_user(user)
      redirect_to root_path, notice: 'Logged In.'
    else
      # puts "*** authentication failed user = #{user.inspect}"
      clear_current_user()
      flash.now.alert = "Invalid credentials"
      @user = User.new({email: email})
      render "new", notice: "Login Failed"
    end
  end 

  def destroy
    puts "Session Controller: destroy. params = #{params}"
    current_user.logout() if current_user
    clear_current_user()
    redirect_to root_path, notice: 'Good-bye'
  end
  
end