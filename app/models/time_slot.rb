class TimeSlot < ApplicationRecord
  belongs_to :technician

  def range(time_slot_id)
    time_slot = TimeSlot.find(time_slot_id)
    time_slot.duration

  end

end
