require 'journeylog'

describe JourneyLog do 

  it 'should check if oystercard is in_journey?' do
    entry_station = "station1"
    subject.start_journey(entry_station)
    expect(subject.in_journey?).to eq(true)
  end

  it "ends journey" do
    entry_station = "station1"
    exit_station = "station2"
    subject.start_journey(entry_station)
    subject.end_journey(exit_station)
    expect(subject.in_journey?).to eq false
  end

  it "adds to journeys list" do
    entry_station = "station1"
    exit_station = "station2"
    subject.start_journey(entry_station)
    expect { subject.end_journey(exit_station) }.to change { subject.journey_list.length }.by 1
  end



  it "adds a Journey to journeys list" do
    journey = double Journey
    allow(subject).to receive(:journey_list).and_return([journey])
    allow(journey).to receive(:entry_station)
    entry_station = "station1"
    exit_station = "station2"
    subject.start_journey(entry_station)
    subject.end_journey(exit_station)
    expect(subject.journey_list[-1]).to respond_to :entry_station
  end


end 