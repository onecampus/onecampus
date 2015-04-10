class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :user_id
      t.integer :twitter_id
      t.string :url
      t.integer :status

      t.timestamps null: false
    end
  end
end
