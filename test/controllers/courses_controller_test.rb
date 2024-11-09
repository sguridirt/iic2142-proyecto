require "test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @course = courses(:language_201) # Using a course without existing requests
    @course_type = course_types(:online_asynchronous)
    @course_request = course_requests(:request1)
    @course_request_status = course_request_statuses(:pending)
    @course_review = course_reviews(:course_review1)
    @user = users(:teacher_user)
    @student = users(:student_user)
    sign_in @user
  end

  test "should get index" do
    get courses_path
    assert_response :success
  end

  test "should get index with search query" do
    get courses_path, params: { query: "Maths" }
    assert_response :success
  end

  test "should get new" do
    get new_course_path
    assert_response :success
  end

  test "should create course" do
    assert_difference('Course.count') do
      post courses_path, params: {
        course: {
          title: "New Test Course",
          description: "Test Description",
          course_type_id: @course_type.id,
          start_date: Date.today,
          end_date: Date.tomorrow
        }
      }
    end
    assert_redirected_to home_path
    assert_equal "Curso creado exitosamente.", flash[:notice]
  end

  test "should show course for teacher" do
    get course_path(@course)
    assert_response :success
    assert_template 'show_teacher'
  end

  test "should show course for admin" do
    sign_in users(:admin_user)
    get course_path(@course)
    assert_response :success
    assert_template 'show_admin'
  end

  test "should show course for student" do
    sign_in users(:student_user)
    get course_path(@course)
    assert_response :success
    assert_template 'show_student'
  end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete course_path(@course)
    end
    assert_redirected_to courses_path
    assert_equal 'Curso eliminado exitosamente.', flash[:notice]
  end

  test "should handle request_join for new student" do
    sign_in @student
    assert_difference('CourseRequest.count') do
      post request_join_course_path(courses(:language_201))
    end
    assert_redirected_to courses_path
  end

  # test "should handle duplicate course request" do
  #   sign_in @student
  #   # First request
  #   post request_join_course_path(courses(:maths_201))
  #   # Second request to same course
  #   post request_join_course_path(courses(:maths_201))
  #   assert_redirected_to courses_path
  #   assert_equal "Ya has solicitado unirte a este curso.", flash[:alert]
  # end

  test "should handle failed course creation" do
    post courses_path, params: {
      course: {
        title: "", # Invalid empty title to trigger error
        description: "Test Description",
        course_type_id: @course_type.id,
        start_date: Date.today,
        end_date: Date.tomorrow
      }
    }
    assert_template :new
    assert_equal "No se pudo crear el curso.", flash[:alert]
  end
end