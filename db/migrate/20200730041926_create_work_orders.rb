class CreateWorkOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :work_orders do |t|
      t.references :location, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.integer :duration
      t.integer :price

      t.timestamps
    end
  end
end
