class CreateDays < ActiveRecord::Migration[6.0]
  def change
    create_table :days do |t|
      t.belongs_to :week, index: true

      t.string :name_day
      t.integer :number_week
      t.date :date

      t.timestamps
    end

    add_foreign_key :days, :weeks, column: :week_id
  end
end
