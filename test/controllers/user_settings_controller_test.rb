require "test_helper"

class UserSettingsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  setup do
    @user = users(:student_user)
    sign_in @user
  end

  test "should get show" do
    get user_settings_path
    assert_response :success
    assert_equal assigns(:user), @user
  end

  test "should get edit" do
    get user_settings_edit_path
    assert_response :success
    assert_equal assigns(:user), @user
    assert_template :update
  end

  test "should update user" do
    patch user_settings_path, params: { user: { name: "New Name", email: "new@example.com" } }
    assert_redirected_to user_settings_path
    assert_equal 'Perfil actualizado exitosamente.', flash[:notice]
    @user.reload
    assert_equal "New Name", @user.name
    assert_equal "new@example.com", @user.email
  end

  test "should not update user with invalid data" do
    patch user_settings_path, params: { user: { email: "invalid" } }
    assert_response :unprocessable_entity
    assert_template :update
  end

  test "should not update user with blank name" do
    patch user_settings_path, params: { user: { name: "" } }
    assert_response :unprocessable_entity
    assert_template :update
  end

  test "should not update user with blank email" do
    patch user_settings_path, params: { user: { email: "" } }
    assert_response :unprocessable_entity
    assert_template :update
  end

  test "should update user with password" do
    patch user_settings_path, params: { user: { 
      password: "newpassword", 
      password_confirmation: "newpassword" 
    } }
    assert_redirected_to user_settings_path
    assert_equal 'Perfil actualizado exitosamente.', flash[:notice]
  end

  test "should not update user with mismatched password confirmation" do
    patch user_settings_path, params: { user: { 
      password: "newpassword", 
      password_confirmation: "wrongconfirmation" 
    } }
    assert_response :unprocessable_entity
    assert_template :update
  end

  test "should require authentication" do
    sign_out @user
    get user_settings_path
    assert_redirected_to new_user_session_path
  end
end