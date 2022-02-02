class CreateWeeks < ActiveRecord::Migration[6.0]
  def change
    create_table :weeks do |t|
      t.belongs_to :service, index: true

      t.string :name_week
      t.integer :number_week
      t.string :range_days
      t.integer :year

      t.timestamps
    end

    add_foreign_key :weeks, :services, column: :service_id
  end
end
