require "test_helper"

class ItemsTest < ActionDispatch::IntegrationTest
  test "index page renders" do
    get items_path
    assert_response :success
    assert_select "h3", text: items(:one).title
  end

  test "index page with search" do
    get items_path, params: { search: "Pentel" }
    assert_response :success
    assert_select "h3", text: items(:one).title
  end

  test "show page renders" do
    get item_path(items(:one))
    assert_response :success
  end

  test "new page requires login" do
    get new_item_path
    assert_redirected_to root_path
  end

  test "new page renders when logged in" do
    post session_path, params: { email: users(:one).email, password: "password123" }
    get new_item_path
    assert_response :success
  end

  test "own requires login" do
    post own_item_path(items(:two))
    assert_redirected_to root_path
  end

  test "own creates ownership" do
    post session_path, params: { email: users(:one).email, password: "password123" }

    assert_difference "Ownership.count", 1 do
      post own_item_path(items(:two))
    end
    assert_redirected_to item_path(items(:two))
  end

  test "own does not duplicate ownership" do
    post session_path, params: { email: users(:one).email, password: "password123" }

    assert_no_difference "Ownership.count" do
      post own_item_path(items(:one))
    end
  end

  test "unown removes ownership" do
    post session_path, params: { email: users(:one).email, password: "password123" }

    assert_difference "Ownership.count", -1 do
      post unown_item_path(items(:one))
    end
    assert_redirected_to item_path(items(:one))
  end

  test "collection requires login" do
    get collection_items_path
    assert_redirected_to new_session_url
  end

  test "collection renders when logged in" do
    post session_path, params: { email: users(:one).email, password: "password123" }
    get collection_items_path
    assert_response :success
  end

  test "edit requires admin" do
    post session_path, params: { email: users(:one).email, password: "password123" }
    get edit_item_path(items(:one))
    assert_response :redirect
  end

  test "edit renders for admin" do
    post session_path, params: { email: users(:admin).email, password: "password123" }
    get edit_item_path(items(:one))
    assert_response :success
  end

  test "destroy requires admin" do
    post session_path, params: { email: users(:one).email, password: "password123" }

    assert_no_difference "Item.count" do
      delete item_path(items(:one))
    end
  end

  test "destroy removes item for admin" do
    post session_path, params: { email: users(:admin).email, password: "password123" }

    assert_difference "Item.count", -1 do
      delete item_path(items(:one))
    end
    assert_redirected_to items_url
  end
end
