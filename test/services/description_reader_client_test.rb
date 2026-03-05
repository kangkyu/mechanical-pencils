require "test_helper"
require "webmock/minitest"

class DescriptionReaderClientTest < ActiveSupport::TestCase
  setup do
    ENV["DESCRIPTION_READER_URL"] = "https://description-reader.example.com"
    @channel_response = [
      { url: "https://www.amazon.com/Pentel-GraphGear-1000/dp/B0006HXQXA", channel_uuids: ["UC_abc123"] }
    ].to_json
  end

  teardown do
    ENV.delete("DESCRIPTION_READER_URL")
  end

  test "sync creates items from amazon links" do
    Influencer.create!(name: "TestChannel", handle: "UC_abc123", platform: "YouTube")

    stub_request(:get, "https://description-reader.example.com/channels")
      .to_return(status: 200, body: @channel_response, headers: { "Content-Type" => "application/json" })

    assert_difference("Item.count", 1) do
      DescriptionReaderClient.sync
    end

    item = Item.last
    assert_equal "https://www.amazon.com/Pentel-GraphGear-1000/dp/B0006HXQXA", item.amazon_url
    assert_equal "Pentel GraphGear 1000", item.title
    assert_includes item.influencers.map(&:handle), "UC_abc123"
  end

  test "sync is idempotent for items" do
    Influencer.create!(name: "TestChannel", handle: "UC_abc123", platform: "YouTube")

    stub_request(:get, "https://description-reader.example.com/channels")
      .to_return(status: 200, body: @channel_response, headers: { "Content-Type" => "application/json" })

    DescriptionReaderClient.sync

    assert_no_difference("Item.count") do
      DescriptionReaderClient.sync
    end
  end

  test "sync creates influencers from channel uuids" do
    stub_request(:get, "https://description-reader.example.com/channels")
      .to_return(status: 200, body: @channel_response, headers: { "Content-Type" => "application/json" })

    assert_difference("Influencer.count", 1) do
      DescriptionReaderClient.sync
    end

    influencer = Influencer.find_by(handle: "UC_abc123")
    assert_equal "YouTube", influencer.platform
    assert_includes Item.last.influencers, influencer
  end

  test "sync creates items without influencer when no channel uuids" do
    stub_request(:get, "https://description-reader.example.com/channels")
      .to_return(
        status: 200,
        body: [{ url: "https://www.amazon.com/Some-Product/dp/B000TEST", channel_uuids: [] }].to_json,
        headers: { "Content-Type" => "application/json" }
      )

    assert_difference("Item.count", 1) do
      DescriptionReaderClient.sync
    end

    assert_empty Item.last.influencers
  end

  test "sync handles network errors gracefully" do
    stub_request(:get, "https://description-reader.example.com/channels")
      .to_timeout

    assert_no_difference("Item.count") do
      DescriptionReaderClient.sync
    end
  end
end
