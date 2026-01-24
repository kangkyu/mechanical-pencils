require "test_helper"

class OwnershipsTest < ActionDispatch::IntegrationTest
  test "edit renders for owner" do
    post session_path, params: { email: users(:one).email, password: "password123" }
    get edit_item_ownership_path(items(:one), ownerships(:one))
    assert_response :success
  end

  test "edit shows form for proof image" do
    post session_path, params: { email: users(:one).email, password: "password123" }
    get edit_item_ownership_path(items(:one), ownerships(:one))
    assert_select "form"
  end

  test "update redirects to item on success" do
    post session_path, params: { email: users(:one).email, password: "password123" }
    patch item_ownership_path(items(:one), ownerships(:one)), params: { ownership: { proof: nil } }
    assert_redirected_to item_path(items(:one))
  end
end
