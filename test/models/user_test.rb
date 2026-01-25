require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid user" do
    user = User.new(email: "test@example.com", password: "password123")

    assert_predicate user, :valid?
  end

  test "invalid without email" do
    user = User.new(password: "password123")

    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "invalid without password" do
    user = User.new(email: "test@example.com")

    assert_not user.valid?
    assert_includes user.errors[:password], "can't be blank"
  end

  test "invalid with duplicate email" do
    User.create!(email: "duplicate@example.com", password: "password123")
    user = User.new(email: "duplicate@example.com", password: "password123")

    assert_not user.valid?
    assert_includes user.errors[:email], "has already been taken"
  end

  test "admin? returns true for admin email" do
    user = users(:admin)

    assert_predicate user, :admin?
  end

  test "admin? returns false for non-admin email" do
    user = users(:one)

    assert_not user.admin?
  end

  test "owned returns true when user owns item" do
    user = users(:one)
    item = items(:one)

    assert user.owned(item)
  end

  test "owned returns false when user does not own item" do
    user = users(:one)
    item = items(:two)

    assert_not user.owned(item)
  end
end
