require 'journeylog'

describe JourneyLog do 

  it 'should check if oystercard is in_journey?' do
    entry_station = "station1"
    subject.start_journey(entry_station)
    expect(subject.in_journey?).to eq(true)
  end

end 