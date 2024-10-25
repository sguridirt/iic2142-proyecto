require "test_helper"

class CourseRequestTest < ActiveSupport::TestCase
  def setup
    @course_request = course_requests(:request1)
  end

  test "should be valid with valid attributes" do
    assert @course_request.valid?
  end

  test "should belong to student" do
    assert_respond_to @course_request, :student
  end

  test "should belong to course" do
    assert_respond_to @course_request, :course
  end

  test "should belong to course_request_status" do
    assert_respond_to @course_request, :course_request_status
  end

  test "should require description" do
    @course_request.description = nil
    assert_not @course_request.valid?
  end

  test "should have correct student association" do
    assert_equal students(:student), @course_request.student
  end

  test "should have correct course association" do
    assert_equal courses(:maths_101), @course_request.course
  end

  test "should have correct status" do
    assert_equal course_request_statuses(:pending), @course_request.course_request_status
  end
end
