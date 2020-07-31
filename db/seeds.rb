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

CSV.foreach(technicians_filepath, csv_options) do |row|
  Technician.find_or_create_by(id: row[0], name: row['name'] )
end

puts 'Technicians added to database, seeding time slots........'

Technician.all.each do |tech|
  start_time = DateTime.strptime( '10/1/2019 4:00', '%m/%d/%Y %k:%M')
  end_time = DateTime.strptime( '10/1/2019 22:00', '%m/%d/%Y %k:%M')

  until start_time == end_time
    TimeSlot.create(start_time: start_time, end_time: (start_time + 5.minutes), duration: 5, technician_id: tech.id)
    start_time += 5.minutes
  end
end

puts 'Time slots added to database, seeding locations.......'

CSV.foreach(locations_filepath, csv_options) do |row|
  Location.find_or_create_by(
    id: row[0], name: row['name'], city: row['city'])
end

puts 'Locations added to database'
# puts 'Seeding Work Orders......'

CSV.foreach(work_orders_filepath, csv_options) do |row|
  start_time = DateTime.strptime( row['time'].insert(5, '20'), '%m/%d/%Y %k:%M')
  # create the work order
  WorkOrder.find_or_create_by( id: row[0], location_id: row['location_id'], start_time: start_time,
                              duration: row['duration'], price: row['price'], end_time: start_time + 5.minutes)
end


# puts 'Work Orders added to database'
# puts 'Database succesfully seeded'
