require 'station'

describe Station do
  
subject(:station) { Station.new("station1", 2) }

 it 'has a name' do
  expect(station.name).to eq ("station1")
 end 

 it 'has a zone' do
  expect(station.zone).to eq (2)
 end 

end 