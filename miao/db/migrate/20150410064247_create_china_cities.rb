class CreateChinaCities < ActiveRecord::Migration
  def change
    create_table :china_cities do |t|
      t.integer :area_code
      t.string :area
      t.integer :parent_code
      t.integer :level

      t.timestamps null: false
    end
  end
end
