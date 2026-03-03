require "test_helper"

class Api::V1::InfluencersTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @token = ApiToken.new(user: @user)
    @token.save!
    @auth_header = { "Authorization" => "Bearer #{@token.raw_token}" }
  end

  test "create influencer with valid params" do
    assert_difference("Influencer.count", 1) do
      post api_v1_influencers_url,
        params: { influencer: { name: "TechReviewer", platform: "YouTube", handle: "@techreviewer", profile_url: "https://youtube.com/@techreviewer" } },
        headers: @auth_header
    end

    assert_response :created
    json = JSON.parse(response.body)
    assert_equal "TechReviewer", json["influencer"]["name"]
    assert_equal "@techreviewer", json["influencer"]["handle"]
  end

  test "create is idempotent - same handle returns existing record" do
    post api_v1_influencers_url,
      params: { influencer: { name: "TechReviewer", platform: "YouTube", handle: "@techreviewer", profile_url: "https://youtube.com/@techreviewer" } },
      headers: @auth_header
    assert_response :created

    assert_no_difference("Influencer.count") do
      post api_v1_influencers_url,
        params: { influencer: { name: "TechReviewer Updated", platform: "YouTube", handle: "@techreviewer", profile_url: "https://youtube.com/@techreviewer" } },
        headers: @auth_header
    end

    assert_response :created
    json = JSON.parse(response.body)
    assert_equal "TechReviewer Updated", json["influencer"]["name"]
  end

  test "create requires authentication" do
    post api_v1_influencers_url,
      params: { influencer: { name: "NoAuth", handle: "@noauth" } }

    assert_response :unauthorized
  end

  test "create fails without name" do
    post api_v1_influencers_url,
      params: { influencer: { handle: "@noname" } },
      headers: @auth_header

    assert_response :unprocessable_entity
    json = JSON.parse(response.body)
    assert_includes json["errors"], "Name can't be blank"
  end
end
