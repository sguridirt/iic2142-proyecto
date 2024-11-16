require "test_helper"

class EvaluationControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @evaluation = evaluations(:evaluation1)

    @student_user = users(:student_user)
    @teacher_user = users(:teacher_user)
    @admin_user = users(:admin_user)
    @student = students(:student)
    @teacher = teachers(:teacher)
    @admin = admins(:admin)
  end
  
  test "should get new" do
    sign_in @teacher_user
    get new_evaluation_url
    assert_response :success
  end
  
  test "should create evaluation" do
    sign_in @teacher_user
    assert_difference('Evaluation.count') do
      post evaluations_url, 
           params: { evaluation: { name: 'Test Evaluation', start_date: Date.today, duration: 60, 
           course_id: courses(:maths_101).id, 
           evaluation_type_id: evaluation_types(:quiz).id } }
    end

    assert_redirected_to course_path(@evaluation.course)
  end

  test "should show evaluation" do
    sign_in @student_user
    get evaluation_path(@evaluation)
    assert_response :success
  end

  test "should destroy evaluation" do
    sign_in @teacher_user
    assert_difference('Evaluation.count', -1) do
      delete evaluation_path(@evaluation)
    end
    assert_redirected_to course_path(@evaluation.course)
  end

  test "should get grading page" do
    sign_in @teacher_user
    @students = @evaluation.students
    get grade_answers_evaluation_path(@evaluation, @student)
    assert_response :success
  end

  test "should update grades" do
    sign_in @teacher_user

    evaluation = evaluations(:evaluation2)
    answer = evaluation_answers(:answer3)
    new_points = 11

    patch update_grades_evaluation_path(evaluation, @student), 
          params: { answers: { answer.id => { points: new_points } } }
    assert_redirected_to grade_answers_evaluation_path(evaluation, @student)
    evaluation.reload
    assert_equal new_points, evaluation.evaluation_answers.find(answer.id).points
  end
end