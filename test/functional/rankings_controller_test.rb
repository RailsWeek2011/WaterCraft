require 'test_helper'

class RankingsControllerTest < ActionController::TestCase
  test "should get rank" do
    get :rank
    assert_response :success
  end

end
