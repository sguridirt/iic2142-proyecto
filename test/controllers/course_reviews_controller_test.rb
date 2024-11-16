require "test_helper"

class CourseReviewsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @student = users(:student_user)
    @course = courses(:maths_101)
    sign_in @student
  end

  test "should get new" do
    get new_course_review_path
    assert_response :success
    assert_template 'reviews/course_review'
  end

  test "should create course review" do
    assert_difference('CourseReview.count') do
      post course_reviews_path, params: {
        course_review: {
          course_id: courses(:language_101).id,
          rating: 4,
          title: "Great Course",
          comment: "Really enjoyed this course"
        }
      }
    end

    assert_redirected_to home_path
    assert_equal 'Reseña de curso creada exitosamente.', flash[:notice]
  end


end