require 'rails_helper'

RSpec.describe WorkOrder, type: :model do
  time = Time.now
  workorder = WorkOrder.new(time: time, duration: 60, price: 30, technician_id: 1, location_id: 1)
  it "has a time" do
    expect(workorder.time).to eq(time)
  end
   it "has a duration" do
    expect(workorder.duration).to eq(60)
  end
  it "has a price" do
    expect(workorder.price).to eq(30)
  end
  it "has a Technician" do
    expect(workorder.technician_id).to eq(1)
  end
  it "has a Location" do
    expect(workorder.location_id).to eq(1)
  end
end
