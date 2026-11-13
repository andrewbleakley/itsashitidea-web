# An app or website someone thinks is a shit idea. Deliberately stores nothing
# about who sent it (no IP, user agent or contact details): anonymity is the product.
class Nomination < ApplicationRecord
  normalizes :idea, with: ->(value) { value.strip }
  normalizes :message, with: ->(value) { value.strip.presence }

  validates :idea, presence: { message: "needs an app name or website" }, length: { maximum: 200 }
  validates :message, length: { maximum: 2000 }
end
