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
    range_start_time = DateTime.parse('10/1/2019 6:00')
    range_end_time = DateTime.parse('10/1/2019 17:00')
    range_start_time = booked_before.sort_by{ |ts| ts.end_time}.last.end_time if booked_before.count > 0
    range_end_time = booked_after.sort_by{ |ts| ts.start_time}.first.start_time if booked_after.count > 0
    range = range_end_time.to_i - range_start_time.to_i
    Time.at(range).utc.strftime('%H:%M')
  end
end
