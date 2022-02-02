class CreateUserServices < ActiveRecord::Migration[6.0]
  def change
    create_table :user_services do |t|
      t.belongs_to :service, index: true
      t.belongs_to :user, index: true

      t.boolean :available, :default => true

      t.timestamps
    end

    add_foreign_key :user_services, :services, column: :service_id
    add_foreign_key :user_services, :users, column: :user_id
  end
end
