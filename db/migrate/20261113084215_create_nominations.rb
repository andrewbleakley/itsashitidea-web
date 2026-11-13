class CreateNominations < ActiveRecord::Migration[8.1]
  def change
    create_table :nominations do |t|
      t.string :idea, null: false
      t.text :message

      t.timestamps
    end
  end
end
