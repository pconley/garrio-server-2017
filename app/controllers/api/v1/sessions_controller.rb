require 'net/http'

module Api
module V1
class SessionsController < ApiController

  def callback
    puts "\n\n***ApiSessionController: callback. params = #{params}" 
  end
  
  def google
    res = ""
    
    puts "\n\n***ApiSessionController: google. params = #{params}" 
    
    code = params[:code]
    client_id = params[:client_id]
    client_secret = 'E_14kJlntj5Pt-cocd2qfmAK'
    
    puts "\nSTEP1 occured on the client. resulting code = #{code}\n"
    
    puts "STEP2 starting\n"
    
    uri2 = URI("https://accounts.google.com/o/oauth2/token")
    http = Net::HTTP.new(uri2.host, uri2.port)
    http.use_ssl = true if uri2.scheme == 'https'
    http.start do |h|
        req = Net::HTTP::Post.new uri2.request_uri
        req.set_form_data(
          'grant_type' => 'authorization_code',
          'client_id' => client_id,
          'client_secret' => client_secret,
          'redirect_uri' => "http://192.168.254.45:3000/api/v1/callback",
          'code' => code
        )
        res = http.request req # Net::HTTPResponse object
    end
    put_result("Step2", res)
       
    # code=4%2FPdBp3aCZ-hxgMv-zpqvBSckIqPrK.YrclHk1CIi4a3oEBd8DOtNCJWIkwigI
    # &redirect_uri=https%3A%2F%2Fdevelopers.google.com%2Foauthplayground
    # &client_id=407408718192.apps.googleusercontent.com
    # &scope=&client_secret=************
    # &grant_type=authorization_code

    
     
    # uri = URI("https://www.googleapis.com/oauth2/v2/userinfo")
    # Net::HTTP.start(uri.host, uri.port) do |http|
    #   request = Net::HTTP::Get.new uri.request_uri
    #   res = http.request request # Net::HTTPResponse object
    # end
    
    # Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https').start do |http|
    #   request = Net::HTTP::Get.new uri.request_uri
    #   res = http.request request # Net::HTTPResponse object
    # end
    # puts "\n\ntest res... #{res}\n"
    
    
    
    # http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = true if uri.scheme == 'https'
    # http.start do |h|
    #     req = Net::HTTP::Get.new uri.request_uri
    #     req['Authorization'] = "hello"
    #     res = http.request req # Net::HTTPResponse object
    #   
    #   # res = h.request Net::HTTP::Get.new(uri.request_uri)
    # end
    # put_result("Step3", res)
    
        
    #parsed = JSON.parse(result)
    # puts "\n\nhttp result... #{parsed}\n\n"
    # puts "\n\nhttp result... #{parsed["geonames"][0]}\n\n"
    
    # HARDCODE LOGIN and RESPONSE
    
    @user = User.first
    respond_via_rabl("Google Successful")
  end
  
  def put_result( title, res)
    puts "\n\n#{title}... #{res}"
    # Headers
    # puts "set cookie = "+ res['Set-Cookie']            # => String
    # puts "get fields = " + res.get_fields('set-cookie') # => Array
    # puts "res as has = " + res.to_hash['set-cookie']    # => Array
    # puts "Headers: #{res.to_hash.inspect}"
    # Status
    puts "code = #{res.code}"
    puts "message = #{res.message}"
    puts "class.name = #{res.class.name}"
    puts "\nbody = #{res.body}\n\n"
  end
  
  def check
    puts "\n\n***ApiSessionController: check. params = #{params}"  
    token = params["token"]
    if !token || token=="" 
      respond_error("check failed. no token.")
    else
      @user = User.find_by_session_token(token)
      if @user && @user.activated
        puts "... check worked"
        respond_via_rabl("Check Successful")
      else
        puts "... check failed"
        respond_error("check failed. invalid token.")
      end
    end
  end 
        
  def create
    puts "\n\n***ApiSessionController: create. params = #{params}"  
    email = params["email"]
    email = params[:user][:email] if params[:user] && params[:user][:email]
    pswd = params["password"]
    pswd = params[:user][:password] if params[:user] && params[:user][:password]
    @user = User.find_by_email(email) || User.find_by_name(email)
    puts "*** user = #{@user} activated=#{@user.try(:activated)}"
    if @user && @user.activated && @user.authenticate(pswd)
      puts "*** authentication worked"
      @user.login() 
      # rabl returns parts of @user
      respond_via_rabl("Login Successful")
    else
      puts "*** authentication failed"
      respond_error("login failed.")
    end
  end 
  
  def destroy
    puts "\n\nApiSessionController: destroy. params = #{params}"
    token = params.require("token")
    user = User.find_by_session_token(token)
    if user
      user.logout()
      respond_result(nil,"logout worked")
    else
      respond_error("logout failed.")  
    end
  end  
  
end
end
end