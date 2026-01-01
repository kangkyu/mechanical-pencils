require "test_helper"

class OwnershipTest < ActiveSupport::TestCase
  test "valid ownership" do
    ownership = Ownership.new(user: users(:two), item: items(:one))
    assert ownership.valid?
  end

  test "invalid without user" do
    ownership = Ownership.new(item: items(:one))
    assert_not ownership.valid?
    assert_includes ownership.errors[:user], "must exist"
  end

  test "invalid without item" do
    ownership = Ownership.new(user: users(:one))
    assert_not ownership.valid?
    assert_includes ownership.errors[:item], "must exist"
  end
end
