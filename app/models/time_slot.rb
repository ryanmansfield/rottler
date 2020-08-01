class TimeSlot < ApplicationRecord
  belongs_to :technician

  def range(time_slot_id)
    current_time_slot = TimeSlot.find(time_slot_id)
    technician = current_time_slot.technician
    technician_booked_time_slots = []

    technician.time_slots.each do |ts|
      technician_booked_time_slots << ts if ts.is_booked?
    end
        # find previous work order
      #save previous work order end time

    #find next work order
      #find next work order start time

    # subtract next start time - previous end time

  end

end
