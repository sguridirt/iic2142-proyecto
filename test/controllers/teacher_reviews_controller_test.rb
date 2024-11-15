require 'test_helper'

class TeacherReviewsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Incluye los helpers de Devise para simular el inicio de sesión

  setup do
    @student = users(:student_user) # Asegúrate de tener un fixture para un usuario estudiante
    @teacher = teachers(:teacher) # Asegúrate de tener un fixture para un profesor
    sign_in @student # Inicia sesión como estudiante
  end

  test "should get new" do
    get new_teacher_review_path
    assert_response :success
    assert_select 'form#new_teacher_review' # Verifica que se renderice el formulario para crear una reseña
  end

  test "should create teacher review" do
    assert_difference('TeacherReview.count', 1) do
      post teacher_reviews_path, params: {
        teacher_review: {
          teacher_id: @teacher.id,
          rating: 4,
          title: 'Great teacher!',
          comment: 'Very knowledgeable and engaging.'
        }
      }
    end
    assert_redirected_to home_path
    follow_redirect!
    assert_match /Reseña de profesor creada exitosamente./, response.body
  end

  test "should not create teacher review with invalid data" do
    assert_no_difference('TeacherReview.count') do
      post teacher_reviews_path, params: {
        teacher_review: {
          teacher_id: @teacher.id,
          rating: -1, # Esto debería hacer que el modelo falle
          title: 'Bad teacher',
          comment: 'The class was boring.'
        }
      }
    end
    assert_template :new # Debería renderizar la vista de 'new' nuevamente
  end

end
