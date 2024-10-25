require "test_helper"

class CourseTest < ActiveSupport::TestCase
  def setup
    @course = courses(:maths_101)
  end

  test "valid course" do
    assert @course.valid?
  end

  test "invalid without title" do
    @course.title = nil
    refute @course.valid?
    assert_not_nil @course.errors[:title]
  end

  test "invalid without description" do
    @course.description = nil
    refute @course.valid?
    assert_not_nil @course.errors[:description]
  end

  test "invalid without start_date" do
    @course.start_date = nil
    refute @course.valid?
    assert_not_nil @course.errors[:start_date]
  end

  test "invalid without end_date" do
    @course.end_date = nil
    refute @course.valid?
    assert_not_nil @course.errors[:end_date]
  end

  test "invalid if end_date is before start_date" do
    @course.start_date = Date.today
    @course.end_date = Date.yesterday
    refute @course.valid?
    assert_includes @course.errors[:end_date], "End date must be after the start date"
  end

  test "invalid if end_date equals start_date" do
    @course.start_date = Date.today
    @course.end_date = Date.today
    refute @course.valid?
    assert_includes @course.errors[:end_date], "End date must be after the start date"
  end

  test "belongs to teacher" do
    assert_respond_to @course, :teacher
    assert_instance_of Teacher, @course.teacher
  end
  

  test "belongs to course_type" do
    assert_respond_to @course, :course_type
  end

  test "has many enrollments" do
    assert_respond_to @course, :enrollments
  end

  test "has many students through enrollments" do
    assert_respond_to @course, :students
  end

  test "has many materials" do
    assert_respond_to @course, :materials
  end

  test "has many evaluations" do
    assert_respond_to @course, :evaluations
  end

  test "destroying course destroys dependent evaluations" do
    assert_difference('Evaluation.count', -@course.evaluations.count) do
      @course.destroy
    end
  end

  test "invalid without teacher" do
    @course.teacher = nil
    refute @course.valid?
    assert_not_nil @course.errors[:teacher]
  end
  
  test "invalid without course_type" do
    @course.course_type = nil
    refute @course.valid?
    assert_not_nil @course.errors[:course_type]
  end
  
end
