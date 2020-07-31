class TimeSlot < ApplicationRecord
  belongs_to :technician
  belongs_to :work_order
end
