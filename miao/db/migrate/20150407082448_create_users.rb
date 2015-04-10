class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :last_name
      t.string :first_name
      t.string :nick_name
      t.string :uid
      t.string :salt
      t.string :pass
      t.string :avatar
      t.string :email
      t.integer :age
      t.integer :university_id
      t.string :address_current
      t.datetime :birthday
      t.string :mobile
      t.string :gender
      t.string :access_token
      t.datetime :expiration_time
      t.string :last_login_ip
      t.string :register_status
      t.datetime :last_sign_in_at
      t.string :language
      t.string :register_type
      t.text :personalized_signature
      t.string :country
      t.string :province
      t.string :city
      t.string :region
      t.string :postcode
      t.string :tel

      t.timestamps null: false
    end
  end
end
