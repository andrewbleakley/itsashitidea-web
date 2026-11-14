class CreateInstagramMessages < ActiveRecord::Migration[8.1]
  def change
    create_table :instagram_messages do |t|
      t.string :mid, null: false
      t.string :sender_igsid, null: false
      t.string :recipient_igsid, null: false
      t.text :text
      t.datetime :sent_at, null: false
      t.jsonb :payload, null: false, default: {}

      t.timestamps
    end

    add_index :instagram_messages, :mid, unique: true
  end
end
