# app/controllers/instagram_webhooks_controller.rb
class InstagramWebhooksController < ActionController::API
  # Meta's one-time check: echo the challenge if the token matches
  def verify
    creds = Rails.application.credentials.instagram
    if params["hub.mode"] == "subscribe" &&
       ActiveSupport::SecurityUtils.secure_compare(params["hub.verify_token"].to_s, creds[:verify_token])
      render plain: params["hub.challenge"]
    else
      head :forbidden
    end
  end

  # Inbound events: check the signature, queue the work, reply 200 fast
  def receive
    body = request.raw_post
    expected = "sha256=" + OpenSSL::HMAC.hexdigest(
      "SHA256", Rails.application.credentials.instagram[:app_secret], body
    )
    unless ActiveSupport::SecurityUtils.secure_compare(expected, request.headers["X-Hub-Signature-256"].to_s)
      return head :unauthorized
    end

    InstagramWebhookJob.perform_later(body)
    head :ok
  end
end
