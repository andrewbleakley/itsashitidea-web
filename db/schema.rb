# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_11_14_043201) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "instagram_mentions", force: :cascade do |t|
    t.string "account_id", null: false
    t.string "media_id", null: false
    t.string "comment_id"
    t.datetime "mentioned_at", null: false
    t.jsonb "payload", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["media_id", "comment_id"], name: "index_instagram_mentions_on_media_id_and_comment_id", unique: true, where: "(comment_id IS NOT NULL)"
    t.index ["media_id"], name: "index_instagram_mentions_on_media_id", unique: true, where: "(comment_id IS NULL)"
  end

  create_table "instagram_messages", force: :cascade do |t|
    t.string "mid", null: false
    t.string "sender_igsid", null: false
    t.string "recipient_igsid", null: false
    t.text "text"
    t.datetime "sent_at", null: false
    t.jsonb "payload", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mid"], name: "index_instagram_messages_on_mid", unique: true
  end

  create_table "nominations", force: :cascade do |t|
    t.string "idea", null: false
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
