class Technician < ApplicationRecord
  has_many :time_slots, dependent: :destroy
  has_many :work_orders, through: :time_slots, dependent: :destroy
end
