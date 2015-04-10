class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      t.integer :university_code
      t.string :name
      t.text :intro
      t.integer :province_code
      t.string :english_name
      t.string :longitude
      t.string :latitude

      t.timestamps null: false
    end
  end
end
