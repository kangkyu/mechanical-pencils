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

  test "destroys join records on destroy" do
    influencer = influencers(:one)
    item = items(:one)

    assert_includes item.influencers, influencer

    influencer.destroy

    assert_not_includes item.reload.influencers, influencer
  end

  test "handle must be unique" do
    Influencer.create!(name: "First", handle: "@unique_handle")
    duplicate = Influencer.new(name: "Second", handle: "@unique_handle")

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:handle], "has already been taken"
  end

  test "allows multiple nil handles" do
    Influencer.create!(name: "No Handle 1", handle: nil)
    second = Influencer.new(name: "No Handle 2", handle: nil)

    assert_predicate second, :valid?
  end
end
