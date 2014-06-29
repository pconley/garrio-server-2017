require 'test_helper'

class RanksControllerTest < ActionController::TestCase
  setup do
    @rank = ranks(:rank1)
    @user1 = users(:user1)
    @user2 = users(:user2)
    login(:user1)
  end

  test "should get index" do
    #trace "\n>>> ranks index"
    get :index
    assert_response :success
    assert_not_nil assigns(:ranks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rank" do
    #trace "\n>>> ranks create"  
    assert_difference('Rank.count') do
      post :create, rank: { language_id: @spanish.id, score: 22, user_id: @user1.id }
    end
    assert_redirected_to rank_path(assigns(:rank))
  end

  test "should show rank" do
    get :show, id: @rank
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rank
    assert_response :success
  end
  
  test "should update rank score" do
    newscore = @rank.score + 3 # random increase
    patch :update, id: @rank, rank: { score: newscore }
    assert_redirected_to rank_path(assigns(:rank))
    @rank.reload # from the database
    assert_equal(@rank.score,newscore)
  end

  test "should destroy rank" do
    assert_difference('Rank.count', -1) do
      delete :destroy, id: @rank
    end
    assert_redirected_to ranks_path
  end
end
