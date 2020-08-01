# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
technicians_filepath = 'technicians.csv'
locations_filepath = 'locations.csv'
work_orders_filepath = 'work_orders.csv'

puts 'Deleting old information from database........'

TimeSlot.delete_all
WorkOrder.delete_all
Technician.delete_all
Location.delete_all

puts 'Database clean, Seeding Technicians.....'

CSV.foreach(technicians_filepath, **csv_options) do |row|
  Technician.find_or_create_by(id: row[0], name: row['name'])
end

puts 'Technicians added to database, seeding time slots........'

Technician.all.each do |tech|
  start_time = DateTime.parse('10/1/2019 6:00')
  end_time = DateTime.parse('10/1/2019 17:00')

  until start_time == end_time
    TimeSlot.create(start_time: start_time, end_time: (start_time + 5.minutes), duration: 5, technician_id: tech.id)
    start_time += 5.minutes
  end
end

puts 'Time slots added to database, seeding locations.......'

CSV.foreach(locations_filepath, **csv_options) do |row|
  Location.find_or_create_by(
    id: row[0], name: row['name'], city: row['city']
  )
end

puts 'Locations added to database, seeding work orders...............'

CSV.foreach(work_orders_filepath, **csv_options) do |row|
  # find the work order start time
  start_time = DateTime.parse(row['time'].insert(5, '20'))

  # create the work order
  workorder = WorkOrder.find_or_create_by(
    id: row[0], location_id: row['location_id'], start_time: start_time,
    duration: row['duration'], price: row['price'],
    end_time: start_time + row['duration'].to_i.minutes
  )
  # # find the wo tech
  technician = Technician.find(row['technician_id'])

  # # #find time slot
  wo_time_slot = technician.time_slots.find_by(start_time: start_time)

  # if !wo_time_slot.present?
  #   byebug
  #   wo_time_slot = TimeSlot.create(start_time: start_time, end_time: (start_time + 5.minutes), duration: 5, technician_id: technician.id)
  # end

  # # # upadate timeslot wo_id / duration / end_time
  wo_time_slot.update(
    work_order_id: workorder.id, duration: workorder.duration,
    end_time: start_time + row['duration'].to_i.minutes, is_booked: true
  )

  # # delete conflicting time slots
  time_slots_to_delete = (row['duration'].to_i - 5) / 5
  id_to_delete = wo_time_slot.id
  time_slots_to_delete.times do
    id_to_delete += 1
    TimeSlot.delete(id_to_delete)
  end
end
puts 'Work Orders added to database'
puts 'Database succesfully seeded'
