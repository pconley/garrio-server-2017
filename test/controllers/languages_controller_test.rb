require 'test_helper'

class LanguagesControllerTest < ActionController::TestCase
  setup do
    @english = languages(:english)
    login(:user1)
  end

  test "should get index" do
    #trace ">>> index language test"
    get :index
    assert_response :success
    # languages are returned in @languages
    assert_not_nil assigns(:languages)
    # asser that ALL the languages are returned
    assert_equal assigns(:languages).length, Language.all.length
  end
  
  test "should show language" do
    #trace ">>> show language test"
    get :show, id: @english
    assert_response :success
    assert_not_nil assigns(:language)
  end
  
end
