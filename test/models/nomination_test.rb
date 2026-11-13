require "test_helper"

class NominationTest < ActiveSupport::TestCase
  test "requires an idea" do
    assert_not Nomination.new(idea: "").valid?
  end

  test "message is optional" do
    assert Nomination.new(idea: "SlopGPT").valid?
  end
end
