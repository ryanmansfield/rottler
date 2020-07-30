class CreateTimeSlots < ActiveRecord::Migration[6.0]
  def change
    create_table :time_slots do |t|
      t.references :technician, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.integer :duration
      t.boolean :is_booked, default: false

      t.timestamps
    end
  end
end
