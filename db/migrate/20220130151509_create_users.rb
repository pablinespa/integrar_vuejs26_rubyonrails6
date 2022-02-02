class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :color
      t.integer :age
      t.string :gender
      t.string :user_role
      t.string :phone_number
      t.date :date_of_birth
      t.string :profile_picture

      t.string :fb_id
      t.string :fb_token
      t.string :google_id
      t.string :google_token
      t.string :apple_id

      t.text :access_token
      t.text :password
      t.text :password_digest

      t.timestamps null: false
    end
  end
end
