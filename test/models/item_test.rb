require "test_helper"

class ItemTest < ActiveSupport::TestCase
  test "valid item" do
    item = Item.new(title: "Test Pencil", item_maker: makers(:one))
    assert item.valid?
  end

  test "invalid without title" do
    item = Item.new(item_maker: makers(:one))
    assert_not item.valid?
    assert_includes item.errors[:title], "can't be blank"
  end

  test "invalid without maker" do
    item = Item.new(title: "Test Pencil")
    assert_not item.valid?
    assert_includes item.errors[:item_maker], "must exist"
  end

  test "with_title scope filters by title" do
    results = Item.with_title("Pentel")
    assert_includes results, items(:one)
    assert_not_includes results, items(:two)
  end

  test "with_title scope is case insensitive" do
    results = Item.with_title("pentel")
    assert_includes results, items(:one)
  end

  test "with_title scope returns all when blank" do
    results = Item.with_title("")
    assert_equal Item.count, results.count
  end
end
