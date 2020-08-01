class TimeSlot < ApplicationRecord
  belongs_to :technician

  def range(time_slot_id)
    current_time_slot = TimeSlot.find(time_slot_id)
    technician = current_time_slot.technician
    booked_before = []
    booked_after = []
    technician.time_slots.each do |time_slot|
      if time_slot.is_booked?
        time_slot.start_time < current_time_slot.start_time ? booked_before << time_slot : booked_after << time_slot
      end
    end
    range_start_time = booked_before.sort_by{ |ts| ts.end_time}.first.end_time
    range_end_time = booked_after.sort_by{ |ts| ts.start_time}.first.end_time

    range = (range_end_time - range_start_time)/1.hour
    range
  end
end
