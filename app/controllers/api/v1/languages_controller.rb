module Api
module V1
class LanguagesController < ApiController
  
  def index
    puts "LanguageController: index.  params = #{params}"
    # token = JWT.encode({"name" => "patrick conley"}, "secret")
    # puts "token = #{token}"
    # payload = JWT.decode(token, "secret")
    # puts "payload = #{payload}"
    # puts "name = #{payload['name']}"
    @languages = Language.all
  end

end
end
end