require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    
    @new_user_params = { admin: false, email: "x@x.xxx", language_id: @english.id, name: "testone" }
    
    login(:user1)
    
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should create user" do
    assert_difference('User.count') do
      post :create, user: @new_user_params
    end
    assert_redirected_to user_path(assigns(:user))
  end
  
  test "should show user" do
    get :show, id: users(:user2)
    assert_response :success
  end
  
  test "should get edit" do
    get :edit, id: users(:user2)
    assert_response :success
  end
  
  test "should update user" do
    patch :update, id: users(:user2), user: { email: "newmail@test.com", name: "newusername" }
    assert_redirected_to user_path(assigns(:user))
  end
  
  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: users(:user2)
    end
    assert_redirected_to users_path
  end
  
end
