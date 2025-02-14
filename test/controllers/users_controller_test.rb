require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get signup" do
    get new_user_url
    assert_response :success
  end
end
