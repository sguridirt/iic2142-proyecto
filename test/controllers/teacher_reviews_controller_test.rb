require "test_helper"

class TeacherReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get teacher_reviews_new_url
    assert_response :success
  end

  test "should get create" do
    get teacher_reviews_create_url
    assert_response :success
  end
end
