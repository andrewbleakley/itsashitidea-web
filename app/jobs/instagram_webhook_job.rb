# Parses a signature-verified Instagram webhook body (Graph API v27.0) and stores
# inbound DMs and mentions. Meta retries deliveries, so both are de-duplicated.
class InstagramWebhookJob < ApplicationJob
  queue_as :default

  def perform(body)
    Array(JSON.parse(body)["entry"]).each do |entry|
      # Live DMs arrive in entry.messaging; the dashboard "Test" button sends
      # them as entry.changes with field "messages". Mentions always use changes.
      Array(entry["messaging"]).each { |event| store_message(event) }

      Array(entry["changes"]).each do |change|
        case change["field"]
        when "messages" then store_message(change["value"])
        when "mentions" then store_mention(entry, change["value"])
        end
      end
    end
  end

  private
    def store_mention(entry, value)
      return if value.blank? || value["media_id"].blank?

      InstagramMention.create_or_find_by!(media_id: value["media_id"], comment_id: value["comment_id"]) do |record|
        record.account_id = entry["id"]
        record.mentioned_at = parse_timestamp(entry["time"])
        record.payload = value
      end
    end

    def store_message(event)
      message = event&.dig("message")
      # Skip non-message events (reactions, reads), our own echoes and deletions.
      return if message.blank? || message["mid"].blank? || message["is_echo"] || message["is_deleted"]

      InstagramMessage.create_or_find_by!(mid: message["mid"]) do |record|
        record.sender_igsid = event.dig("sender", "id")
        record.recipient_igsid = event.dig("recipient", "id")
        record.text = message["text"]
        record.sent_at = parse_timestamp(event["timestamp"])
        record.payload = event
      end
    end

    # Live events send milliseconds; the dashboard sample sends seconds as a string.
    def parse_timestamp(value)
      number = Integer(value)
      Time.zone.at(number > 10_000_000_000 ? number / 1000.0 : number)
    end
end
