# Someone @mentioned our Instagram account, in a comment (comment_id present)
# or in a post caption (media_id only). account_id is our own account's ID.
class InstagramMention < ApplicationRecord
  validates :account_id, :media_id, :mentioned_at, presence: true
end
