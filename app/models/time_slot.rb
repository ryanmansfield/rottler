class TimeSlot < ApplicationRecord
  belongs_to :technician

  # def range_duration(time_slot_id)
  #   current_time_slot = TimeSlot.find(time_slot_id)
  #   technician = current_time_slot.technician
  #   booked_before = []
  #   booked_after = []
  #   technician.time_slots.each do |time_slot|
  #     if time_slot.is_booked?
  #       time_slot.start_time < current_time_slot.start_time ? booked_before << time_slot : booked_after << time_slot
  #     end
  #   end
  #   find_range(booked_before, booked_after)
  # end

  # private

  # def find_range(booked_before, booked_after)
  #   range_start_time = find_start_time(booked_before)
  #   range_end_time = find_end_time(booked_after)

  #   range = range_end_time.to_i - range_start_time.to_i
  #   Time.at(range).utc.strftime('%H:%M')
  # end

  # def find_start_time(booked_before)
  #   booked_before.count.positive? ? booked_before.max_by(&:end_time).end_time : DateTime.parse('10/1/2019 6:00')
  # end

  # def find_end_time(booked_after)
  #   booked_after.count.positive? ? booked_after.min_by(&:start_time).start_time : DateTime.parse('10/1/2019 17:00')
  # end
end
