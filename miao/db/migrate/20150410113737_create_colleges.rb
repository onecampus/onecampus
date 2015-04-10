class CreateColleges < ActiveRecord::Migration
  def change
    create_table :colleges do |t|
      t.integer :college_code
      t.string :name
      t.text :intro
      t.integer :university_code

      t.timestamps null: false
    end
  end
end
