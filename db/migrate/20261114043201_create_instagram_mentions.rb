class CreateInstagramMentions < ActiveRecord::Migration[8.1]
  def change
    create_table :instagram_mentions do |t|
      t.string :account_id, null: false
      t.string :media_id, null: false
      t.string :comment_id
      t.datetime :mentioned_at, null: false
      t.jsonb :payload, null: false, default: {}

      t.timestamps
    end

    # Caption mentions have no comment_id. Two partial indexes keep both kinds
    # unique without needing Postgres 15's NULLS NOT DISTINCT.
    add_index :instagram_mentions, [ :media_id, :comment_id ], unique: true, where: "comment_id IS NOT NULL"
    add_index :instagram_mentions, :media_id, unique: true, where: "comment_id IS NULL"
  end
end
