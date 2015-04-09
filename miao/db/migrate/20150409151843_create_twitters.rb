class CreateTwitters < ActiveRecord::Migration
  def change
    create_table :twitters do |t|
      t.integer :user_id
      t.text :content
      t.string :source
      t.string :url
      t.integer :parent_id
      t.integer :anonymous
      t.string :longitude
      t.string :latitude

      t.timestamps null: false
    end
  end
end
