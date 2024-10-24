require "test_helper"

class CourseTest < ActiveSupport::TestCase
  def setup
    @user_role = UserRole.create!(
      name: 'Teacher',
      description: 'A user who can create and manage courses for students.'
    )
    
    @teacher_user = User.create!(
      email: "test_teacher@test.com",
      name: "Test Teacher",
      phone: "+56900000099",
      password: "password123",
      password_confirmation: "password123",
      user_role: @user_role
    )
    
    @teacher = Teacher.create!(user: @teacher_user)
    
    @course_type = CourseType.create!(
      name: "Test Type",
      description: "Test course type description"
    )
    
    @course = Course.new(
      title: "Test Course",
      description: "Test course description",
      start_date: Date.today,
      end_date: Date.today + 30.days,
      teacher: @teacher,
      course_type: @course_type
    )
  end

  test "should be valid with valid attributes" do
    assert @course.valid?
  end

  test "should require a title" do
    @course.title = nil
    assert_not @course.valid?
  end

  test "should require a description" do
    @course.description = nil
    assert_not @course.valid?
  end

  test "should require a start date" do
    @course.start_date = nil
    assert_not @course.valid?
  end

  test "should require an end date" do
    @course.end_date = nil
    assert_not @course.valid?
  end

  test "should require a teacher" do
    @course.teacher = nil
    assert_not @course.valid?
    assert_includes @course.errors[:teacher], "must exist"
  end

  test "should require a course type" do
    @course.course_type = nil
    assert_not @course.valid?
    assert_includes @course.errors[:course_type], "must exist"
  end

  test "should not allow end date before start date" do
    @course.end_date = @course.start_date - 1.day
    assert_not @course.valid?
    assert_includes @course.errors[:end_date], "End date must be after the start date"
  end

  test "should allow valid date range" do
    @course.start_date = Date.today
    @course.end_date = Date.today + 1.day
    assert @course.valid?
  end

  test "should allow equal start and end dates" do
    @course.start_date = Date.today
    @course.end_date = Date.today
    assert_not @course.valid?
  end

  test "should have many enrollments" do
    assert_respond_to @course, :enrollments
  end

  test "should have many students through enrollments" do
    assert_respond_to @course, :students
  end

  test "should have many materials" do
    assert_respond_to @course, :materials
  end

  test "should have many evaluations" do
    assert_respond_to @course, :evaluations
  end

  test "should destroy dependent evaluations" do
    @course.save!
    evaluation_type = EvaluationType.create!(name: "Test Type", description: "Test description")
    evaluation = @course.evaluations.create!(
      name: "Test Eval",
      start_date: Date.today,
      duration: 60,
      evaluation_type: evaluation_type
    )
    
    assert_difference "Evaluation.count", -1 do
      @course.destroy
    end
  end
end
