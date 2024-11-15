require "test_helper"

class StudentTest < ActiveSupport::TestCase
  def setup
    @student = students(:student)
    @course = courses(:maths_101)
    @wishlist = wishlists(:wishlist)
  end

  test "should be valid with a user" do
    assert @student.valid?
  end

  test "should not be valid without a user" do
    @student.user = nil
    assert_not @student.valid?
  end

  test "should create a wishlist after creation" do
    student = Student.create(user: users(:student_user))
    assert_not_nil student.wishlist
  end

  test "should be enrolled in a course" do
    @student.enrollments << Enrollment.create(student: @student, course: @course, enrollment_date: Date.today)
    assert @student.enrolled_in_course?(@course)
  end

  test "should destroy associated course requests" do
    assert_difference('CourseRequest.count', -@student.course_requests.count) do
      @student.destroy
    end
  end

  test "should destroy associated enrollments" do
    assert_difference('Enrollment.count', -@student.enrollments.count) do
      @student.destroy
    end
  end

  test "should destroy associated evaluation answers" do
    assert_difference('EvaluationAnswer.count', -@student.evaluation_answers.count) do
      @student.destroy
    end
  end

  test "should destroy associated evaluation feedbacks" do
    assert_difference('EvaluationFeedback.count', -@student.evaluation_feedbacks.count) do
      @student.destroy
    end
  end

  test "should destroy associated wishlist" do
    assert_difference('Wishlist.count', -1) do
      @student.destroy
    end
  end
end
