require "test_helper"

class ComplaintsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test "should get new" do
    sign_in users(:student_user)
    get new_complaint_url
    assert_response :success
  end

  test "should create complaint" do
    sign_in users(:student_user)
    post complaints_url, params: { complaint: {title: "Queja", content: "banana"}}
    assert_redirected_to home_url
  end

  test "should not create complaint with missing parameters" do
    sign_in users(:student_user)
    post complaints_url, params: { complaint: { title: "", content: "" } }
    assert_response :unprocessable_entity
  end
end
