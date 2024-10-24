require "test_helper"

class MaterialTypeTest < ActiveSupport::TestCase
  def setup
    @material_type = MaterialType.new(
      name: "Video",
      description: "A video resource"
    )
  end

  test "should be valid with valid attributes" do
    assert @material_type.valid?
  end

  test "should have a name" do
    @material_type.name = nil
    assert_not @material_type.valid?
    assert_includes @material_type.errors[:name], "can't be blank"
  end

  test "should have a description" do
    @material_type.description = nil
    assert_not @material_type.valid?
    assert_includes @material_type.errors[:description], "can't be blank"
  end

  test "should have unique name" do
    duplicate_material_type = @material_type.dup
    @material_type.save
    assert_not duplicate_material_type.valid?
    assert_includes duplicate_material_type.errors[:name], "has already been taken"
  end

  test "should have many materials" do
    assert_respond_to @material_type, :materials
  end

  test "should save successfully" do
    assert @material_type.save
  end

  test "should not save with empty name" do
    @material_type.name = ""
    assert_not @material_type.save
  end

  test "should not save with empty description" do
    @material_type.description = ""
    assert_not @material_type.save
  end

  test "should be able to update attributes" do
    @material_type.save
    assert @material_type.update(name: "Document", description: "A document resource")
  end

  test "should be able to destroy" do
    @material_type.save
    assert @material_type.destroy
  end
end
