require 'test_helper'

class LikeControllerTest < ActionDispatch::IntegrationTest
  test "should get user:belongs_to" do
    get like_user:belongs_to_url
    assert_response :success
  end

  test "should get post:belongs_to" do
    get like_post:belongs_to_url
    assert_response :success
  end

end
