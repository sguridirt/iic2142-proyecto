require "test_helper"

class UserRoleTest < ActiveSupport::TestCase
  # Reference fixtures
  fixtures :user_roles

  def setup
    @student_role = user_roles(:student)
    @teacher_role = user_roles(:teacher)
    @admin_role = user_roles(:admin)
  end

  test "should be valid with valid attributes" do
    assert @student_role.valid?
  end

  test "should have many users" do
    assert_respond_to @student_role, :users
  end

  test "should be able to update attributes" do
    assert @student_role.update(description: "Updated student role description")
  end

  test "should find existing role" do
    found_role = UserRole.find_by(name: "Student")
    assert_equal @student_role, found_role
  end

  test "should list all roles" do
    assert_equal 3, UserRole.count
  end

  test "should validate presence of name" do
    role = UserRole.new(description: "Test description")
    assert_not role.valid?
  end

  test "should validate presence of description" do
    role = UserRole.new(name: "Test role")
    assert_not role.valid?
  end

  test "should validate uniqueness of name" do
    duplicate_role = UserRole.new(
      name: "Student",
      description: "Duplicate student role"
    )
    assert_not duplicate_role.valid?
  end

  test "should handle empty description" do
    role = UserRole.new(name: "Test role", description: "")
    assert_not role.valid?
  end

  test "should handle empty name" do
    role = UserRole.new(name: "", description: "Test description")
    assert_not role.valid?
  end

  test "should handle role with users" do
    user = User.create!(
      email: "test@test.com",
      password: "password",
      phone: "+56912345678",
      name: "Test User",
      user_role: @student_role
    )
    assert_includes @student_role.users, user
  end

  test "should not allow role deletion with users" do
    User.create!(
      email: "test@test.com",
      password: "password",
      phone: "+56912345678",
      name: "Test User",
      user_role: @student_role
    )
    assert_not @student_role.destroy
  end

  test "should not update with empty name" do
    assert_not @student_role.update(name: "")
  end

  test "should not update with empty description" do
    assert_not @student_role.update(description: "")
  end

  test "should not update with duplicate name" do
    assert_not @student_role.update(name: "Teacher")
  end
end
