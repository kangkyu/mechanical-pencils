require "test_helper"

class ThreadsAccountTest < ActiveSupport::TestCase
  test "valid threads account" do
    account = ThreadsAccount.new(user: users(:one), threads_user_id: "12345")
    assert account.valid?
  end

  test "invalid without user" do
    account = ThreadsAccount.new(threads_user_id: "12345")
    assert_not account.valid?
    assert_includes account.errors[:user], "must exist"
  end

  test "stores and retrieves short_access_token" do
    account = ThreadsAccount.create!(user: users(:one), threads_user_id: "12345")
    account.short_access_token = "secret_short_token"
    account.save!

    account.reload
    assert_equal "secret_short_token", account.short_access_token
  end

  test "stores and retrieves long_access_token" do
    account = ThreadsAccount.create!(user: users(:one), threads_user_id: "12345")
    account.long_access_token = "secret_long_token"
    account.save!

    account.reload
    assert_equal "secret_long_token", account.long_access_token
  end

  test "tokens are encrypted in database" do
    account = ThreadsAccount.create!(user: users(:one), threads_user_id: "12345")
    account.short_access_token = "plaintext_token"
    account.save!

    raw_tokens = ThreadsAccount.connection.select_value(
      "SELECT tokens FROM threads_accounts WHERE id = #{account.id}"
    )
    parsed = JSON.parse(raw_tokens)

    assert_not_equal "plaintext_token", parsed["short_access_token"]
  end
end
