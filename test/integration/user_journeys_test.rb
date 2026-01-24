require "test_helper"

class UserJourneysTest < ActionDispatch::IntegrationTest
  test "guest can browse items and view details" do
    # Visit homepage
    get root_path

    assert_response :success

    # Browse items catalog
    get items_path

    assert_response :success
    assert_select "h3", text: items(:one).title

    # View item details
    get item_path(items(:one))

    assert_response :success
  end

  test "guest is redirected when trying to own item" do
    get items_path

    assert_response :success

    post own_item_path(items(:one))

    assert_redirected_to root_path
  end

  test "user can login and own an item" do
    # Login
    post session_path, params: { email: users(:two).email, password: "password123" }

    assert_redirected_to root_path
    follow_redirect!

    # Browse to item
    get item_path(items(:one))

    assert_response :success

    # Own the item
    assert_difference "Ownership.count", 1 do
      post own_item_path(items(:one))
    end
    assert_redirected_to item_path(items(:one))
  end

  test "user can view their collection after owning items" do
    # Login
    post session_path, params: { email: users(:one).email, password: "password123" }
    follow_redirect!

    # View collection (user one already owns item one via fixtures)
    get collection_items_path

    assert_response :success
  end

  test "user can own and then unown an item" do
    # Login as user two who doesn't own item one
    post session_path, params: { email: users(:two).email, password: "password123" }

    # Own an item
    assert_difference "Ownership.count", 1 do
      post own_item_path(items(:one))
    end

    # Unown the item
    assert_difference "Ownership.count", -1 do
      post unown_item_path(items(:one))
    end
  end

  test "user can search for items" do
    get items_path, params: { search: "Pentel" }

    assert_response :success
    assert_select "h3", text: items(:one).title

    get items_path, params: { search: "Rotring" }

    assert_response :success
    assert_select "h3", text: items(:two).title
  end

  test "user can browse item groups" do
    get item_groups_path

    assert_response :success

    get item_group_path(item_groups(:one))

    assert_response :success
    assert_select "h1", text: item_groups(:one).title
  end

  test "user can view another user profile" do
    # Login as user one
    post session_path, params: { email: users(:one).email, password: "password123" }

    # View user two's profile
    get user_path(users(:two))

    assert_response :success
  end

  test "full authentication flow" do
    # Start logged out, visit login page
    get new_session_path

    assert_response :success

    # Login
    post session_path, params: { email: users(:one).email, password: "password123" }

    assert_redirected_to root_path

    # Verify logged in - can access collection
    get collection_items_path

    assert_response :success

    # Logout
    delete session_path

    assert_redirected_to new_session_url

    # Verify logged out - collection redirects
    get collection_items_path

    assert_redirected_to new_session_url
  end

  test "admin can manage items" do
    # Login as admin
    post session_path, params: { email: users(:admin).email, password: "password123" }

    # Edit item
    get edit_admin_item_path(items(:one))

    assert_response :success

    # Update item
    patch admin_item_path(items(:one)), params: { item: { title: "Updated Pencil" } }

    assert_redirected_to item_path(items(:one))

    # Verify update
    get item_path(items(:one))

    assert_select "h1", text: /Updated Pencil/
  end

  test "admin can manage item groups" do
    # Login as admin
    post session_path, params: { email: users(:admin).email, password: "password123" }

    # Create new group
    assert_difference "ItemGroup.count", 1 do
      post admin_item_groups_path, params: { item_group: { title: "New Collection" } }
    end

    # Edit the group
    new_group = ItemGroup.last
    get edit_admin_item_group_path(new_group)

    assert_response :success

    # Delete the group
    assert_difference "ItemGroup.count", -1 do
      delete admin_item_group_path(new_group)
    end
  end

  test "non-admin cannot access admin functions" do
    # Login as regular user
    post session_path, params: { email: users(:one).email, password: "password123" }

    # Try to edit item - should redirect
    get edit_admin_item_path(items(:one))

    assert_response :redirect

    # Try to delete item - should not work
    assert_no_difference "Item.count" do
      delete admin_item_path(items(:one))
    end
  end
end
