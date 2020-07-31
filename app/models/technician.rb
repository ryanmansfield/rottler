class Technician < ApplicationRecord
  has_many :time_slots
  has_many :work_orders, through: :time_slots
end
