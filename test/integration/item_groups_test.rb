require "test_helper"

class ItemGroupsTest < ActionDispatch::IntegrationTest
  test "show page renders" do
    get item_group_path(item_groups(:one))
    assert_response :success
  end

  test "show page displays group title" do
    get item_group_path(item_groups(:one))
    assert_select "h1", text: item_groups(:one).title
  end
end
