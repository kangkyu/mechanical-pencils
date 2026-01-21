require "test_helper"

class ItemGroupsTest < ActionDispatch::IntegrationTest
  test "index page renders" do
    get item_groups_path
    assert_response :success
  end

  test "show page renders" do
    get item_group_path(item_groups(:one))
    assert_response :success
  end

  test "show page displays group title" do
    get item_group_path(item_groups(:one))
    assert_select "h1", text: item_groups(:one).title
  end

  test "admin new requires admin" do
    post session_path, params: { email: users(:one).email, password: "password123" }
    get new_admin_item_group_path
    assert_response :redirect
  end

  test "admin new renders for admin" do
    post session_path, params: { email: users(:admin).email, password: "password123" }
    get new_admin_item_group_path
    assert_response :success
  end

  test "admin create requires admin" do
    post session_path, params: { email: users(:one).email, password: "password123" }

    assert_no_difference "ItemGroup.count" do
      post admin_item_groups_path, params: { item_group: { title: "New Group" } }
    end
  end

  test "admin create works for admin" do
    post session_path, params: { email: users(:admin).email, password: "password123" }

    assert_difference "ItemGroup.count", 1 do
      post admin_item_groups_path, params: { item_group: { title: "New Group" } }
    end
  end

  test "admin edit requires admin" do
    post session_path, params: { email: users(:one).email, password: "password123" }
    get edit_admin_item_group_path(item_groups(:one))
    assert_response :redirect
  end

  test "admin edit renders for admin" do
    post session_path, params: { email: users(:admin).email, password: "password123" }
    get edit_admin_item_group_path(item_groups(:one))
    assert_response :success
  end

  test "admin destroy requires admin" do
    post session_path, params: { email: users(:one).email, password: "password123" }

    assert_no_difference "ItemGroup.count" do
      delete admin_item_group_path(item_groups(:one))
    end
  end

  test "admin destroy removes item group for admin" do
    post session_path, params: { email: users(:admin).email, password: "password123" }

    assert_difference "ItemGroup.count", -1 do
      delete admin_item_group_path(item_groups(:one))
    end
    assert_redirected_to item_groups_path
  end
end
