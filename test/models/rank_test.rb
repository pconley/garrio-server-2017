require 'test_helper'

class RankTest < ActiveSupport::TestCase
  
  setup do
    @user1 = users(:user1)
    # this needs to be a lanuage not already assigned to the user
    @minumum_rank_params = { score: 25, user: @user1, language: @spanish }
  end
  
  test "should create rank with minumum params" do    
    rank = Rank.new(@minumum_rank_params)
    assert rank.save, "Failed to save the rank with minimum params"
  end
  
  test "should not save rank without score" do
    @minumum_rank_params.delete(:score)
    rank = Rank.new(@minumum_rank_params)
    assert_not rank.save, "Saved a rank without a score"
  end
  
  test "should not save rank without user" do
    @minumum_rank_params.delete(:user)
    rank = Rank.new(@minumum_rank_params)
    assert_not rank.save, "Saved a rank without a user"
  end
  
  test "should not save rank without language" do
    @minumum_rank_params.delete(:language)
    rank = Rank.new(@minumum_rank_params)
    assert_not rank.save, "Saved a rank without a language"
  end
      
end
