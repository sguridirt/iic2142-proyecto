require "test_helper"

class Users::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @student_role = user_roles(:student)
    @teacher_role = user_roles(:teacher)
  end

  test "should get new registration page" do
    get new_user_registration_path
    assert_response :success
  end

  test "should create new user with student role" do
    assert_difference('User.count') do
      post user_registration_path, params: {
        user: {
          email: "newstudent@test.com",
          password: "salero",
          password_confirmation: "salero",
          name: "New Student",
          phone: "+56900000004",
          user_role_id: @student_role.id
        }
      }
    end
    assert_redirected_to '/home'
  end

  test "should set default role as Student for new registration" do
    get new_user_registration_path
    assert_select "form[action=?]", user_registration_path
  end

  test "should not create user with invalid params" do
    assert_no_difference('User.count') do
      post user_registration_path, params: {
        user: {
          email: "",
          password: "salero",
          password_confirmation: "salero"
        }
      }
    end
    assert_response :unprocessable_entity
  end
end
