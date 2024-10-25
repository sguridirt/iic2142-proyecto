require "test_helper"

class CourseReviewTest < ActiveSupport::TestCase
  def setup
    @course_review = course_reviews(:course_review1)
  end

  test "should be valid with valid attributes" do
    assert @course_review.valid?
  end

  test "should belong to student" do
    assert_respond_to @course_review, :student
  end

  test "should belong to course" do
    assert_respond_to @course_review, :course
  end

  test "should have correct rating" do
    assert_equal 5, @course_review.rating
  end

  test "should have correct title" do
    assert_equal "Excellent Course", @course_review.title
  end

  test "should have correct comment" do
    assert_equal "Highly recommend!", @course_review.comment
  end

  test "should be associated with correct course" do
    assert_equal courses(:maths_101), @course_review.course
  end

  test "should be associated with correct student" do
    assert_equal students(:student), @course_review.student
  end
end
