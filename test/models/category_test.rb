require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(name: "sports")
  end

  test "category should be valid" do
    assert @category.valid?
  end

  test "name must be present" do
    @category.name = ""
    assert @category.invalid?
  end

  test "name must be unique" do
    @category.save
    category_with_exiting_name = Category.new(name: "sports")
    assert category_with_exiting_name.invalid?
  end

  test "name should not be to long" do
    @category.name = "a" * 26
    assert @category.invalid?
  end

  test "name should not be to short" do
    @category.name = "aa"
    assert @category.invalid?
  end
end
