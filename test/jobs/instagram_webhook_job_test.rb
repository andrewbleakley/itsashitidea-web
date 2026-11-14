require "test_helper"

class InstagramWebhookJobTest < ActiveJob::TestCase
  test "stores the message from the dashboard test sample" do
    body = {
      object: "instagram",
      entry: [ { id: "0", time: 1527459824, changes: [ {
        field: "messages",
        value: {
          sender: { id: "12334" }, recipient: { id: "23245" }, timestamp: "1527459824",
          message: { mid: "random_mid", text: "random_text" }
        }
      } ] } ]
    }.to_json

    assert_difference "InstagramMessage.count", 1 do
      InstagramWebhookJob.perform_now(body)
    end

    message = InstagramMessage.last
    assert_equal "random_mid", message.mid
    assert_equal "12334", message.sender_igsid
    assert_equal "23245", message.recipient_igsid
    assert_equal "random_text", message.text
    assert_equal Time.zone.at(1527459824), message.sent_at
  end

  test "stores live messaging events once, with millisecond timestamps, and skips echoes" do
    body = {
      object: "instagram",
      entry: [ { id: "23245", time: 1763092800000, messaging: [
        { sender: { id: "12334" }, recipient: { id: "23245" }, timestamp: 1763092800000,
          message: { mid: "mid_1", text: "slopgpt.ai is a shit idea" } },
        { sender: { id: "23245" }, recipient: { id: "12334" }, timestamp: 1763092801000,
          message: { mid: "mid_2", text: "Sorry, but noted.", is_echo: true } }
      ] } ]
    }.to_json

    assert_difference "InstagramMessage.count", 1 do
      2.times { InstagramWebhookJob.perform_now(body) }
    end

    assert_equal Time.zone.at(1763092800), InstagramMessage.find_by!(mid: "mid_1").sent_at
  end
end
