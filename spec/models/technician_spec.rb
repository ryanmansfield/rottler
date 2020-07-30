require 'rails_helper'

RSpec.describe Technician, type: :model do
technician = Technician.new(name:"Ryan Mansfield")
  it "has a name" do
    expect(technician.name).to eq("Ryan Mansfield")
  end
end
