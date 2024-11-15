require "test_helper"

class EvaluationFeedbackTest < ActiveSupport::TestCase
  def setup
    @evaluation_feedback = evaluation_feedbacks(:feedback1)
  end

  test "should be valid with valid attributes" do
    assert @evaluation_feedback.valid?
  end

  test "should not be valid without content" do
    @evaluation_feedback.content = nil
    assert_not @evaluation_feedback.valid?
  end

  test "should belong to an evaluation" do
    assert_not_nil @evaluation_feedback.evaluation
  end

  test "should belong to a student" do
    assert_not_nil @evaluation_feedback.student
  end

  test "should belong to a teacher" do
    assert_not_nil @evaluation_feedback.teacher
  end
end
