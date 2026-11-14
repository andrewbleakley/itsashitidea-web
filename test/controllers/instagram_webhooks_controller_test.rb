require "test_helper"

class InstagramWebhooksControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  BODY = {
    object: "instagram",
    entry: [ { id: "0", time: 1794629446, changes: [ {
      field: "messages",
      value: { sender: { id: "12334" }, recipient: { id: "23245" }, timestamp: "1527459824",
               message: { mid: "random_mid", text: "random_text" } }
    } ] } ]
  }.to_json

  setup do
    @previous_secret = ENV["INSTAGRAM_APP_SECRET"]
    ENV["INSTAGRAM_APP_SECRET"] = "test-app-secret"
  end

  teardown { ENV["INSTAGRAM_APP_SECRET"] = @previous_secret }

  test "queues a correctly signed webhook" do
    signature = "sha256=" + OpenSSL::HMAC.hexdigest("SHA256", "test-app-secret", BODY)

    assert_enqueued_with(job: InstagramWebhookJob, args: [ BODY ]) do
      post "/webhooks/instagram", params: BODY,
        headers: { "Content-Type" => "application/json", "X-Hub-Signature-256" => signature }
    end

    assert_response :ok
  end

  test "rejects a webhook with a bad signature" do
    assert_no_enqueued_jobs do
      post "/webhooks/instagram", params: BODY,
        headers: { "Content-Type" => "application/json", "X-Hub-Signature-256" => "sha256=nope" }
    end

    assert_response :unauthorized
  end
end
