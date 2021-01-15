require "journey"

describe Journey do 

  subject(:journey) { Journey.new("station1", "station2") }

  it 'returns entry_station given' do 
    expect(journey.entry_station).to eq "station1" 
  end 

  it 'returns exit_station given' do
    expect(journey.exit_station).to eq "station2"
  end 

  describe "#initialize" do
    it 'initializes with two arguments' do
      expect(Journey).to respond_to(:new).with(2).arguments
    end 
  end 

end