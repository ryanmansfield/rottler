class WorkOrder < ApplicationRecord
  belongs_to :location
  has_many :time_slots
end
