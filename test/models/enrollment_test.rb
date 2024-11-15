require "test_helper"

class EnrollmentTest < ActiveSupport::TestCase
  def setup
    @enrollment = enrollments(:enrollment1)
    @student = students(:student)
    @course = courses(:maths_101)
  end

  test "should be valid with valid attributes" do
    assert @enrollment.valid?
  end

  test "should not be valid without a student" do
    @enrollment.student = nil
    assert_not @enrollment.valid?
  end

  test "should not be valid without a course" do
    @enrollment.course = nil
    assert_not @enrollment.valid?
  end

  test "should belong to a student" do
    assert_not_nil @enrollment.student
  end

  test "should belong to a course" do
    assert_not_nil @enrollment.course
  end

  test "should not allow duplicate enrollments for the same student and course" do
    duplicate_enrollment = @enrollment.dup
    assert_not duplicate_enrollment.valid?
  end
end
