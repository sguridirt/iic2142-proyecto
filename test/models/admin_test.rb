require "test_helper"

class AdminTest < ActiveSupport::TestCase
  def setup
    @admin = admins(:admin) # Usa el fixture de admins
  end

  test "should be valid" do
    assert @admin.valid?
  end

  test "should belong to a user" do
    assert_not_nil @admin.user
    assert_equal users(:admin_user), @admin.user
  end

  test "user role should be admin" do
    assert_equal "Admin", @admin.user.user_role.name
  end

  test "should destroy associated admin if user is deleted" do
    assert_difference "Admin.count", -1 do
      @admin.user.destroy
    end
  end
end
