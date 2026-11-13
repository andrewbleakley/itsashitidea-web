require "test_helper"

class NominationsControllerTest < ActionDispatch::IntegrationTest
  test "saves a nomination and thanks the sender" do
    assert_difference "Nomination.count", 1 do
      post nominations_path, params: { nomination: { idea: " slopgpt.ai ", message: "" } }
    end

    assert_redirected_to root_path(anchor: "nominate")
    assert_equal "slopgpt.ai", Nomination.last.idea
    assert_nil Nomination.last.message
  end

  test "re-renders the form when the idea is missing" do
    assert_no_difference "Nomination.count" do
      post nominations_path, params: { nomination: { idea: "  ", message: "Hmm" } }
    end

    assert_response :unprocessable_entity
    assert_select "#idea-error", /needs an app name or website/
  end
end
