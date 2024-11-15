require "test_helper"

class EvaluationAnswerTest < ActiveSupport::TestCase
  def setup
    @evaluation_answer = evaluation_answers(:answer3)
  end

  test "should be valid with valid attributes" do
    assert @evaluation_answer.valid?
  end

  test "should not be valid without content" do
    @evaluation_answer.content = nil
    assert_not @evaluation_answer.valid?
  end

  test "should not be valid without points" do
    @evaluation_answer.points = nil
    assert_not @evaluation_answer.valid?
  end

  test "should not be valid with non-integer points" do
    @evaluation_answer.points = 2.5
    assert_not @evaluation_answer.valid?
  end

  test "should not be valid with negative points" do
    @evaluation_answer.points = -1
    assert_not @evaluation_answer.valid?
  end

  test "should belong to an evaluation question" do
    assert_not_nil @evaluation_answer.evaluation_question
  end

  test "should belong to a student" do
    assert_not_nil @evaluation_answer.student
  end
end
