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

# Technician.all.each do |tech|
#   start_time = DateTime.parse('10/1/2019 6:00')
#   end_time = DateTime.parse('10/1/2019 17:00')

#   until start_time == end_time
#     TimeSlot.create(start_time: start_time, end_time: (start_time + 5.minutes), duration: 5, technician_id: tech.id)
#     start_time += 5.minutes
#   end
# end

Technician.all.each do |tech|
  start_time = DateTime.parse('10/1/2019 6:00')
  end_time = DateTime.parse('10/1/2019 17:00')
  duration = (end_time.to_i - start_time.to_i) / 60

  TimeSlot.create(start_time: start_time, end_time: end_time, duration: duration, technician_id: tech.id)
end

# test



puts 'Time slots added to database, seeding locations.......'

CSV.foreach(locations_filepath, **csv_options) do |row|
  Location.find_or_create_by(
    id: row[0], name: row['name'], city: row['city']
  )
end

puts 'Locations added to database, seeding work orders...............'

# CSV.foreach(work_orders_filepath, **csv_options) do |row|
#   # find the work order start time
#   start_time = DateTime.parse(row['time'].insert(5, '20'))

#   # create the work order
#   workorder = WorkOrder.find_or_create_by(
#     id: row[0], location_id: row['location_id'], start_time: start_time,
#     duration: row['duration'], price: row['price'],
#     end_time: start_time + row['duration'].to_i.minutes
#   )
#   # # find the wo tech
#   technician = Technician.find(row['technician_id'])

#   # # #find time slot
#   wo_time_slot = technician.time_slots.find_by(start_time: start_time)

#   # # # upadate timeslot wo_id / duration / end_time
#   wo_time_slot.update(
#     work_order_id: workorder.id, duration: workorder.duration,
#     end_time: start_time + row['duration'].to_i.minutes, is_booked: true
#   )

#   # # delete conflicting time slots
#   time_slots_to_delete = (row['duration'].to_i - 5) / 5
#   id_to_delete = wo_time_slot.id
#   time_slots_to_delete.times do
#     id_to_delete += 1
#     TimeSlot.delete(id_to_delete)
#   end
# end

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

  # Find the Time Slot the Work Order Belongs to

  # Loop Through Tech TS
  technician.time_slots.each do |time_slot|
    # Find Time Slot Range
    range = time_slot.start_time..time_slot.end_time
    # check if new work order start time is in that time slots range
    if range.include?(workorder.start_time) && time_slot.start_time == workorder.start_time
      # update time slot start time to work order end time and create new time slot for work order
      time_slot.update(start_time: workorder.end_time, duration: (time_slot.end_time.to_i - workorder.end_time.to_i) / 60)
      TimeSlot.create(start_time: workorder.start_time, end_time: workorder.end_time, duration: workorder.duration, technician_id: technician.id, work_order_id: workorder.id, is_booked: true)

    elsif range.include?(workorder.start_time) && time_slot.end_time == workorder.end_time
      # update timeslots time and create a new one

    elsif range.include?(workorder.start_time)
      # create time slot before
      TimeSlot.create(start_time: time_slot.start_time, end_time: workorder.start_time, duration: (workorder.start_time.to_i - time_slot.start_time.to_i) / 60, technician_id: technician.id)
      # create wo time slot
      TimeSlot.create(start_time: workorder.start_time, end_time: workorder.end_time, duration: workorder.duration, technician_id: technician.id, work_order_id: workorder.id, is_booked: true)
      # create time slot after
      TimeSlot.create(start_time: workorder.end_time, end_time: time_slot.end_time, duration: (time_slot.end_time.to_i - workorder.end_time.to_i) / 60, technician_id: technician.id)
      # delete orginal time slot
      TimeSlot.delete(time_slot)
    end
  end
end



puts 'Work Orders added to database'
puts 'Database succesfully seeded'
