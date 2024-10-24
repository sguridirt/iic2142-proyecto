require "test_helper"

class UserRoleTest < ActiveSupport::TestCase
  def setup
    @user_role = UserRole.new(
      name: "Student",
      description: "A student role"
    )
  end

  test "should be valid with valid attributes" do
    assert @user_role.valid?
  end

  test "should save successfully" do
    assert @user_role.save
  end

  test "should have many users" do
    assert_respond_to @user_role, :users
  end

  test "should be able to update attributes" do
    @user_role.save
    assert @user_role.update(name: "Teacher", description: "A teacher role")
  end

  test "should be able to destroy" do
    @user_role.save
    assert @user_role.destroy
  end

  test "should create with different roles" do
    teacher_role = UserRole.new(name: "Teacher", description: "A teacher role")
    admin_role = UserRole.new(name: "Admin", description: "An admin role")
    
    assert teacher_role.valid?
    assert admin_role.valid?
  end

  test "should find existing role" do
    @user_role.save
    found_role = UserRole.find_by(name: "Student")
    assert_equal @user_role, found_role
  end

  test "should list all roles" do
    @user_role.save
    UserRole.create(name: "Teacher", description: "A teacher role")
    assert_equal 2, UserRole.count
  end

  test "should validate presence of name" do
    @user_role.name = nil
    assert_not @user_role.valid?
  end

  test "should validate presence of description" do
    @user_role.description = nil
    assert_not @user_role.valid?
  end

  test "should validate uniqueness of name" do
    @user_role.save
    duplicate_role = @user_role.dup
    assert_not duplicate_role.valid?
  end

  test "should handle empty description" do
    @user_role.description = ""
    assert_not @user_role.valid?
  end

  test "should handle empty name" do
    @user_role.name = ""
    assert_not @user_role.valid?
  end

  test "should handle role with users" do
    @user_role.save
    user = User.create!(
      email: "test@test.com",
      password: "password",
      phone: "+56912345678",
      name: "Test User",
      user_role: @user_role
    )
    assert_includes @user_role.users, user
  end

  test "should not allow role deletion with users" do
    @user_role.save
    User.create!(
      email: "test@test.com",
      password: "password",
      phone: "+56912345678",
      name: "Test User",
      user_role: @user_role
    )
    assert_not @user_role.destroy
  end

  test "should not save without name" do
    @user_role.name = nil
    assert_not @user_role.save
  end

  test "should not save without description" do
    @user_role.description = nil
    assert_not @user_role.save
  end

  test "should not save with duplicate name" do
    @user_role.save
    duplicate_role = UserRole.new(name: "Student", description: "Another student role")
    assert_not duplicate_role.save
  end

  test "should update description only" do
    @user_role.save
    assert @user_role.update(description: "Updated student role description")
  end

  test "should not update with empty name" do
    @user_role.save
    assert_not @user_role.update(name: "")
  end

  test "should not update with empty description" do
    @user_role.save
    assert_not @user_role.update(description: "")
  end
end