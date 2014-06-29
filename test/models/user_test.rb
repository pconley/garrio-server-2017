require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  setup do
    @minumum_user_params = { email: "xxxxxx", name: "sometestname", language: @english }
  end
  
  test "should create user with minumum params" do    
    user = User.new(@minumum_user_params)
    assert user.save, "Failed to save the user with minimum params"
  end
  
  test "should not save user without name" do
    @minumum_user_params.delete(:name)
    user = User.new(@minumum_user_params)
    assert_not user.save, "Saved a user without an name"
  end
  
  test "should not save user without language" do
    @minumum_user_params.delete(:language)
    user = User.new(@minumum_user_params)
    assert_not user.save, "Saved a user without an language"
  end
    
  test "should not save user without email" do
    @minumum_user_params.delete(:email)
    user = User.new(@minumum_user_params)
    assert_not user.save, "Saved a user without an email"
  end
  
  test "should not save user with short email" do
    @minumum_user_params[:email] = "xx"
    user = User.new(@minumum_user_params)
    assert_not user.save, "Saved the user with short email"
  end
    
end
