# Parses a signature-verified Instagram webhook body (Graph API v27.0) and stores
# each inbound DM. Meta retries deliveries, so messages are de-duplicated on mid.
class InstagramWebhookJob < ApplicationJob
  queue_as :default

  def perform(body)
    Array(JSON.parse(body)["entry"]).each do |entry|
      events_in(entry).each { |event| store(event) }
    end
  end

  private
    # Live deliveries put events in entry.messaging; the dashboard "Test" button
    # sends them as entry.changes with field "messages".
    def events_in(entry)
      Array(entry["messaging"]) +
        Array(entry["changes"]).filter_map { |change| change["value"] if change["field"] == "messages" }
    end

    def store(event)
      message = event["message"]
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
