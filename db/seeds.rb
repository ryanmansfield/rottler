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

puts 'Reseting database........'

WorkOrder.delete_all
Technician.delete_all
Location.delete_all


puts 'Database Reset, Seeding Technicians.....'

CSV.foreach(technicians_filepath, csv_options) do |row|
  puts "#{row[0]} - #{row['name']}"
  Technician.find_or_create_by(id: row[0], name: row['name'] )
end

puts 'Technicians added to database'

puts 'Seeding Locations.......'

CSV.foreach(locations_filepath, csv_options) do |row|
  puts "#{row[0]} - #{row['name']} - #{row['city']}"
  Location.find_or_create_by(
    id: row[0], name: row['name'], city: ['city'])
end

puts 'Locations added to database'

puts 'Seeding Work Orders......'

CSV.foreach(work_orders_filepath, csv_options) do |row|
  puts "#{row['id']} - #{row['technician_id']} - #{row['location_id']} - #{row['time']} - #{row['duration']} - #{row['price']}"
  WorkOrder.find_or_create_by( id: row[0], technician_id: row['technician_id'],
                              location_id: row['location_id'], time: row['time'],
                              duration: row['duration'], price: row['price']
                              )
end


puts 'Work Orders added to database'

puts 'Database succesfully seeded'
