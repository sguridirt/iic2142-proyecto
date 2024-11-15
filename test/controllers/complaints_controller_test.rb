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
    assert_redirected_to home_path
  end

  test "should not create complaint with missing parameters" do
    sign_in users(:student_user)
    post complaints_url, params: { complaint: { title: "", content: "" } }
    assert_response :unprocessable_entity
  end

  test "should get index" do
    sign_in users(:student_user)
    get complaints_url
    assert_response :success
    assert_not_nil assigns(:complaints)
  end

  test "should show complaint" do
    sign_in users(:student_user)
    complaint = complaints(:complaint1)
    get complaint_url(complaint)
    assert_response :success
  end

  test "should redirect new when not signed in" do
    get new_complaint_url
    assert_redirected_to new_user_session_url
  end

  test "should redirect create when not signed in" do
    post complaints_url, params: { complaint: { title: "Queja", content: "banana" } }
    assert_redirected_to new_user_session_url
  end

  test "should redirect index when not signed in" do
    get complaints_url
    assert_redirected_to new_user_session_url
  end

  test "should redirect show when not signed in" do
    complaint = complaints(:complaint1)
    get complaint_url(complaint)
    assert_redirected_to new_user_session_url
  end
end
