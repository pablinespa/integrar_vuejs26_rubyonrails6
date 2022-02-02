class CreateHours < ActiveRecord::Migration[6.0]
  def change
    create_table :hours do |t|
      t.belongs_to :day, index: true
      t.belongs_to :service, index: true

      t.string :hour_start
      t.string :hour_end
      t.string :name_day
      t.string :range_hour

      t.timestamps
    end

    add_foreign_key :hours, :days, column: :day_id
    add_foreign_key :hours, :services, column: :service_id
  end
end
