require "test_helper"

class ItemGroupTest < ActiveSupport::TestCase
  test "valid item group" do
    item_group = ItemGroup.new(title: "Test Group")

    assert_predicate item_group, :valid?
  end

  test "invalid without title" do
    item_group = ItemGroup.new

    assert_not item_group.valid?
    assert_includes item_group.errors[:title], "can't be blank"
  end
end
