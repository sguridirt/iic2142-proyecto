require "test_helper"
class WishlistsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should redirect if not signed in" do
    get wishlist_path
    assert_redirected_to new_user_session_path
  end
  
  test "should redirect if not student" do
    sign_in users(:teacher_user)
    get wishlist_path
    assert_redirected_to home_path
  end

  test "should get wishlist" do
    sign_in users(:student_user)
    get wishlist_path
    assert_not_nil assigns(:wishlist_courses)
  end

  test "should add course to wishlist" do
    student_user = users(:student_user)
    sign_in student_user
    course = courses(:language_201)

    assert_difference('student_user.student.wishlist.courses.count', 1) do
      post wishlist_path, params: { course_id: course.id }
    end
    assert_redirected_to courses_path
    assert_equal 'Curso añadido a tu wishlist', flash[:notice]
  end

  test "should remove course from wishlist" do
    student_user = users(:student_user)
    sign_in student_user

    student = student_user.student
    wishlist = student.wishlist
    course = courses(:language_201)
    wishlist.courses << course

    assert_difference('wishlist.courses.count', -1) do
      delete wishlist_url(course_id: course.id)
    end
    assert_redirected_to wishlist_path
    assert_equal 'Curso eliminado de tu wishlist', flash[:notice]
  end
end