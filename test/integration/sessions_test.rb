require "test_helper"

class SessionsTest < ActionDispatch::IntegrationTest
  test "login page renders" do
    get new_session_path

    assert_response :success
  end

  test "login page redirects when already signed in" do
    post session_path, params: { email: users(:one).email, password: "password123" }
    get new_session_path

    assert_redirected_to root_url
  end

  test "successful login" do
    post session_path, params: { email: users(:one).email, password: "password123" }

    assert_redirected_to root_path
    follow_redirect!

    assert_response :success
  end

  test "failed login with wrong password" do
    post session_path, params: { email: users(:one).email, password: "wrongpassword" }

    assert_response :unprocessable_entity
  end

  test "failed login with nonexistent email" do
    post session_path, params: { email: "nobody@example.com", password: "password123" }

    assert_response :unprocessable_entity
  end

  test "logout clears session" do
    post session_path, params: { email: users(:one).email, password: "password123" }
    delete session_path

    assert_redirected_to new_session_url
  end
end
