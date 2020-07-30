class CreateWorkOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :work_orders do |t|
      t.refrences :technician
      t.refrences :location
      t.datetime :time
      t.integer :duration
      t.integer :price

      t.timestamps
    end
  end
end
