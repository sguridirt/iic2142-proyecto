require "test_helper"

class MaterialTypeTest < ActiveSupport::TestCase
  def setup
    @material_type = material_types(:video)
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
    duplicate_material_type = MaterialType.new(
      name: material_types(:video).name,
      description: "Another video resource"
    )
    assert_not duplicate_material_type.valid?
    assert_includes duplicate_material_type.errors[:name], "has already been taken"
  end

  test "should have many materials" do
    assert_respond_to @material_type, :materials
  end

  test "should save successfully" do
    new_material_type = MaterialType.new(
      name: "Quiz",
      description: "A quiz resource"
    )
    assert new_material_type.save
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
    assert @material_type.update(name: "Updated Video", description: "An updated video resource")
  end

  test "should be able to destroy" do
    new_material_type = MaterialType.create!(name: "Temporary", description: "Temporary type")
    assert new_material_type.destroy
  end
  
end
