class CreateUserAvailabilities < ActiveRecord::Migration[6.0]
  def change
    create_table :user_availabilities do |t|
      t.belongs_to :hour, index: true
      t.belongs_to :user, index: true

      t.boolean :available, :default => true

      t.timestamps
    end

    add_foreign_key :user_availabilities, :hours, column: :hour_id
    add_foreign_key :user_availabilities, :users, column: :user_id
  end
end
