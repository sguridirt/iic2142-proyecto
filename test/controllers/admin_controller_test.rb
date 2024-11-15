require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Incluye los helpers de Devise

  setup do
    # Crear un usuario administrador y loguearlo
    @admin = users(:admin_user) # Asegúrate de tener un fixture para un usuario administrador con la propiedad admin?
    sign_in @admin

    # Crear datos necesarios
    @user = users(:student_user) # Fixture para un usuario estudiante
    @teacher_review = teacher_reviews(:teacher_review1) # Fixture de una reseña de profesor
    @course_review = course_reviews(:course_review1)   # Fixture de una reseña de curso
    @course = courses(:maths_101)           # Fixture de un curso existente, ajustado al nombre
    @course_type = course_types(:in_person)   # Fixture para tipo de curso, ajustado al nombre
    @teacher = teachers(:teacher)          # Fixture para un profesor, ajustado al nombre
  end





  test "should create user" do
    assert_difference("User.count", 1) do
      post admin_users_path, params: {
        user: {
          name: "Nuevo Usuario",
          email: "nuevo@ejemplo.com",
          phone: "123456789",
          password: "password",
          password_confirmation: "password",
          user_role_id: user_roles(:student).id  # Ajustado al fixture de roles de usuario
        }
      }
    end
    assert_redirected_to admin_view_users_path
    follow_redirect!
    assert_match /Usuario creado exitosamente/, response.body
  end



  test "should update user" do
    patch admin_user_path(@user), params: {
      user: {
        name: "Usuario Actualizado",
        email: "actualizado@ejemplo.com"
      }
    }
    assert_redirected_to admin_view_users_path
    follow_redirect!
    assert_match /Usuario actualizado exitosamente/, response.body
    @user.reload
    assert_equal "Usuario Actualizado", @user.name
  end



  test "should destroy teacher_review" do
    assert_difference("TeacherReview.count", -1) do
      delete admin_destroy_teacher_review_path(@teacher_review)
    end
    assert_redirected_to admin_teacher_reviews_path
    follow_redirect!
    assert_match /Reseña eliminada exitosamente/, response.body
  end


  test "should destroy course_review" do
    assert_difference("CourseReview.count", -1) do
      delete admin_destroy_course_review_path(@course_review)
    end
    assert_redirected_to admin_course_reviews_path
    follow_redirect!
    assert_match /Reseña de curso eliminada exitosamente/, response.body
  end



  test "should create admin_course" do
    assert_difference("Course.count", 1) do
      post create_admin_course_path, params: {
        course: {
          title: "Nuevo Curso",
          description: "Descripción del curso",
          start_date: "2024-01-01",
          end_date: "2024-06-01",
          course_type_id: @course_type.id,  # Ajustado al fixture del tipo de curso
          teacher_id: @teacher.id            # Ajustado al fixture del profesor
        }
      }
    end
    assert_redirected_to home_path
    follow_redirect!
    assert_match /Curso creado exitosamente/, response.body
  end

  test "should update course" do
    patch update_admin_course_path(@course), params: {
      course: {
        title: "Curso Actualizado"
      }
    }
    assert_redirected_to home_path
    follow_redirect!
    assert_match /El curso fue actualizado con éxito/, response.body
    @course.reload
    assert_equal "Curso Actualizado", @course.title
  end

end
