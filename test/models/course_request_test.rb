require "test_helper"

class CourseRequestTest < ActiveSupport::TestCase
  def setup
    @teacher_role = UserRole.create!(
      name: 'Teacher',
      description: 'A user who can create and manage courses.'
    )
    
    @teacher_user = User.create!(
      email: "test_teacher@test.com",
      name: "Test Teacher",
      phone: "+56900000097",
      password: "password123",
      password_confirmation: "password123",
      user_role: @teacher_role
    )
    
    @teacher = Teacher.create!(user: @teacher_user)
    
    @course_type = CourseType.create!(
      name: "Test Type",
      description: "Test Description"
    )
    
    @student_role = UserRole.create!(
      name: 'Student',
      description: 'A user who can enroll in courses.'
    )
    
    @student_user = User.create!(
      email: "test_student@test.com",
      name: "Test Student",
      phone: "+56900000098",
      password: "password123",
      password_confirmation: "password123",
      user_role: @student_role
    )
    
    @student = Student.create!(user: @student_user)
    
    @course = Course.create!(
      title: "Test Course",
      description: "Test Description",
      start_date: Date.today,
      end_date: Date.today + 30.days,
      teacher: @teacher,
      course_type: @course_type
    )
    
    @status = CourseRequestStatus.create!(
      name: "pending",
      description: "Request is pending approval"
    )
    
    @course_request = CourseRequest.new(
      description: "I want to join this course",
      start_date: Date.today,
      end_date: Date.today + 30.days,
      student: @student,
      course: @course,
      course_request_status: @status
    )
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
end
