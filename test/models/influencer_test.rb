require "test_helper"

class InfluencerTest < ActiveSupport::TestCase
  test "valid influencer" do
    influencer = Influencer.new(name: "Test Creator")

    assert_predicate influencer, :valid?
  end

  test "invalid without name" do
    influencer = Influencer.new

    assert_not influencer.valid?
    assert_includes influencer.errors[:name], "can't be blank"
  end

  test "has many items" do
    influencer = influencers(:one)

    assert_respond_to influencer, :items
  end

  test "nullifies items on destroy" do
    influencer = influencers(:one)
    item = items(:one)

    assert_equal influencer, item.influencer

    influencer.destroy

    assert_nil item.reload.influencer_id
  end
end
