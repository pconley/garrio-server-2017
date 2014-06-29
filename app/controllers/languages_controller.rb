class LanguagesController < ApplicationController
          
  # GET /languages
  # GET /languages.json
  def index
    trace "LanguageController: index"
    ### this is just test code to explore using JWT
    token = JWT.encode({"name" => "patrick conley"}, "secret")
    trace "token = #{token}"
    payload = JWT.decode(token, "secret")
    trace "payload = #{payload}"
    trace "name = #{payload[0]['name']}"
    @languages = Language.all
  end

  # GET /languages/1
  # GET /languages/1.json
  def show
    @language = Language.find(params[:id])
  end

private
    
  def trace(s)
    #puts s
  end
  
end
