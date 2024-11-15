require "test_helper"

class EvaluationQuestionTest < ActiveSupport::TestCase
  def setup
    @evaluation_question = evaluation_questions(:question1_eval1)
  end

  test "should be valid with valid attributes" do
    assert @evaluation_question.valid?
  end

  test "should not be valid without content" do
    @evaluation_question.content = nil
    assert_not @evaluation_question.valid?
  end

  test "should not be valid without max_points" do
    @evaluation_question.max_points = nil
    assert_not @evaluation_question.valid?
  end

  test "should not be valid with negative max_points" do
    @evaluation_question.max_points = -1
    assert_not @evaluation_question.valid?
  end

  test "should belong to an evaluation" do
    assert_not_nil @evaluation_question.evaluation
  end

  test "should destroy associated evaluation answers" do
    assert_difference('EvaluationAnswer.count', -@evaluation_question.evaluation_answers.count) do
      @evaluation_question.destroy
    end
  end
end