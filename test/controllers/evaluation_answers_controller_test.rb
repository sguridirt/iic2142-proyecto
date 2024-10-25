require 'test_helper'

class EvaluationAnswersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:student_user)
    @student = students(:student)
    @course = courses(:maths_101)
    @evaluation = evaluations(:evaluation1)
    @evaluation_question = evaluation_questions(:question1_eval1)

    sign_in @user
  end

  test "should create evaluation answer" do
    assert_difference('EvaluationAnswer.count') do
      post evaluation_evaluation_answers_path(@evaluation), 
           params: { answers: { @evaluation_question.id => { content: 'Sample answer', 
evaluation_question_id: @evaluation_question.id, student_id: @student.id } } }
    end

    Rails.logger.debug "Hola"
    assert_redirected_to course_path(@course)
    assert_equal 'Respuestas guardadas correctamente.', flash[:notice]
  end
end