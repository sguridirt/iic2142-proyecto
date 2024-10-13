require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get view_users" do
    get admin_view_users_url
    assert_response :success
  end
end
