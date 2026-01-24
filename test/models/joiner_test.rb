require "test_helper"

class JoinerTest < ActiveSupport::TestCase
  test "valid joiner" do
    joiner = Joiner.new(item_group: item_groups(:two), item: items(:one))

    assert_predicate joiner, :valid?
  end

  test "invalid without item_group" do
    joiner = Joiner.new(item: items(:one))

    assert_not joiner.valid?
    assert_includes joiner.errors[:item_group], "must exist"
  end

  test "invalid without item" do
    joiner = Joiner.new(item_group: item_groups(:one))

    assert_not joiner.valid?
    assert_includes joiner.errors[:item], "must exist"
  end
end
