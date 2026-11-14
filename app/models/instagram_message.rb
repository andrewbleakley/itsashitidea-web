# A DM sent to our Instagram account, received through Meta's messaging webhook.
# sender_igsid is kept only so we can reply in the same thread. Never show, email
# or pass it on to anyone, least of all the person whose idea is being roasted.
class InstagramMessage < ApplicationRecord
  validates :mid, :sender_igsid, :recipient_igsid, :sent_at, presence: true
end
