require "test_helper"

class Users::SessionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:student_user)
  end

  test "should redirect to home after sign in" do
    sign_in @user
    post user_session_path
    assert_redirected_to '/home'
  end

  test "should get sign in page" do
    get new_user_session_path
    assert_response :success
  end

  test "should sign in user with valid credentials" do
    post user_session_path, params: { 
      user: { 
        email: @user.email, 
        password: 'salero'
      } 
    }
    assert_redirected_to '/home'
  end
end