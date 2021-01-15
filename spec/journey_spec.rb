require "journey"

describe Journey do 

  subject(:journey) { Journey.new("station1", "station2") }
  let(:journey1) { Journey.new("station1", nil) }

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

  describe "#fare" do
    it { is_expected.to respond_to :fare }

    it "returns minimum fare" do
      expect(journey.fare).to eq Journey::MINIMUM_FARE
    end

    it "returns penalty fare if no entry/exit" do
      expect(journey1.fare).to eq Journey::PENALTY_FARE
    end

  end

end