require "test_helper"

class CourseRequestStatusTest < ActiveSupport::TestCase
  def setup
    @status = CourseRequestStatus.new(
      name: "pending",
      description: "Request is pending approval"
    )
  end

  test "should be valid with valid attributes" do
    assert @status.valid?
  end
end
