require "test_helper"

class LandingTest < ActionDispatch::IntegrationTest
  test "root page renders" do
    get root_path
    assert_response :success
  end
end
