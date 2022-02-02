class CreateServices < ActiveRecord::Migration[6.0]
  def change
    create_table :services do |t|
      t.string :name
      t.string :day_hour_start
      t.string :day_hour_end
      t.integer :hour_range

      t.integer :monday_hour_start
      t.integer :monday_hour_end
      t.integer :tuesday_hour_start
      t.integer :tuesday_hour_end
      t.integer :wednesday_hour_start
      t.integer :wednesday_hour_end
      t.integer :thursday_hour_start
      t.integer :thursday_hour_end
      t.integer :friday_hour_start
      t.integer :friday_hour_end
      t.integer :saturday_hour_start
      t.integer :saturday_hour_end
      t.integer :sunday_hour_start
      t.integer :sunday_hour_end

      t.timestamps
    end
  end
end
