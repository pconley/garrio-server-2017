ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all
    
  # helper methods to be used by all tests here...
  
  setup do
      setup_languages
  end
   
  def setup_languages
    @danish = languages(:danish) # Language.create!({ :code=>"da", :flag=>"dk", :name=>"Dansk"})
    @english = languages(:english) # Language.create!({ :code=>"en", :flag=>"gb", :name=>"English"})
    @spanish = languages(:spanish) # Language.create!({ :code=>"es", :flag=>"es", :name=>"Español"})
    @italian = languages(:italian) # Language.create!({ :code=>"it", :flag=>"it", :name=>"Italiano"})
    @japanese = languages(:japanese) # Language.create!({ :code=>"ja", :flag=>"jp", :name=>"日本語"})
  end
  
  def trace(s)
    puts s
  end
  
  def error_path
    root_path
  end
  
  def login(user_symbol)
    # pass one of the user symbols from the yaml
    # file. so example usage is    login(:admin)
    user = users(user_symbol)
    session[:user_id] = user.id
  end
 
end
