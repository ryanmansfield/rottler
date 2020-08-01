class TimeSlot < ApplicationRecord
  belongs_to :technician

  def range(time_slot_id)
    current_time_slot = TimeSlot.find(time_slot_id)
    technician = current_time_slot.technician_id
    technician
    # find previous work order
      #save previous work order end time

    #find next work order
      #find next work order start time

    # subtract next start time - previous end time

  end

end
