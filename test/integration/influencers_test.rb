require "test_helper"

class InfluencersTest < ActionDispatch::IntegrationTest
  test "index page renders" do
    get influencers_path

    assert_response :success
  end

  test "index page displays influencer names" do
    get influencers_path

    assert_select "h3", text: influencers(:one).name
    assert_select "h3", text: influencers(:two).name
  end

  test "show page renders" do
    get influencer_path(influencers(:one))

    assert_response :success
  end

  test "show page displays influencer name" do
    get influencer_path(influencers(:one))

    assert_select "h1", text: influencers(:one).name
  end

  test "admin edit requires admin" do
    post session_path, params: { email: users(:one).email, password: "password123" }
    get edit_admin_influencer_path(influencers(:one))

    assert_response :redirect
  end

  test "admin edit renders for admin" do
    post session_path, params: { email: users(:admin).email, password: "password123" }
    get edit_admin_influencer_path(influencers(:one))

    assert_response :success
  end

  test "admin destroy requires admin" do
    post session_path, params: { email: users(:one).email, password: "password123" }

    assert_no_difference "Influencer.count" do
      delete admin_influencer_path(influencers(:one))
    end
  end

  test "admin destroy removes influencer for admin" do
    post session_path, params: { email: users(:admin).email, password: "password123" }

    assert_difference "Influencer.count", -1 do
      delete admin_influencer_path(influencers(:one))
    end
    assert_redirected_to influencers_url
  end
end
