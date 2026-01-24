require "test_helper"

class UsersTest < ActionDispatch::IntegrationTest
  # User profile (show page) tests
  test "show page renders for any user" do
    get user_path(users(:one))
    assert_response :success
  end

  test "show page displays photo collection header" do
    get user_path(users(:one))
    assert_select "h1", text: /Photo Collection/
  end

  test "show page displays share button" do
    get user_path(users(:one))
    assert_select "button", text: /Share/
  end

  test "show page for nonexistent user returns 404" do
    get user_path(id: 999999)
    assert_response :not_found
  end

  # Share page tests
  test "share page renders" do
    get share_user_path(users(:one))
    assert_response :success
  end

  test "share page accessible when logged in" do
    post session_path, params: { email: users(:one).email, password: "password123" }
    get share_user_path(users(:one))
    assert_response :success
  end

  # Threads OAuth callback tests
  test "threads auth redirects on access denied" do
    get "/threads/oauth/callback", params: { error: "access_denied", state: users(:one).id }
    assert_redirected_to user_path(users(:one))
  end
end
