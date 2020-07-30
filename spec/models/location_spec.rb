require 'rails_helper'

RSpec.describe Location, type: :model do
  location = Location.new(name:"CVS", city:"New York")
  it "has a name" do
    expect(location.name).to eq("CVS")
  end
   it "has a city" do
    expect(location.city).to eq("New York")
  end
end
