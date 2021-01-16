require 'oystercard'
require "journey"

describe Oystercard do

  let(:entry_station){double :station}
  let(:exit_station){double :station}
  let(:journey) { double :journey, MINIMUM_FARE: 1, PENALTY_FARE: 6  }



  describe "card without top up" do

    it "should check a card starts with 0 balance" do
      expect(subject.balance).to eq(0)
    end

    it 'should raise an error if balance is less than 1' do
      expect { subject.touch_in(entry_station) }.to raise_error "No money"
    end

  end

  describe "card is topped up and touched in" do
    before(:each) do
      subject.top_up(20)
      subject.touch_in(entry_station)
    end


  describe '#top_up' do
 
    it "should top up balance" do
      expect{ subject.top_up(20) }.to change{ subject.balance }.by 20
    end

    it 'raises an error if the maximum balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE 
      expect{ subject.top_up(maximum_balance) }.to raise_error 'Maximum balance of #{maximum_balance} exceeded'
    end 

  end 

  describe "#in_journey" do

    it 'should check if oystercard is in_journey?' do
      expect(subject.in_journey?).to eq(true)
    end

    it 'no longer in_journey after touch out' do
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to eq (false)
    end 
    
  end

  describe '#touch_out' do
    
    it 'should touch out oystercard' do
      subject.touch_out(exit_station)
      expect(subject.history.length).to eq 1
    end

    it 'should take off minimum cost when touching out' do
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-journey.MINIMUM_FARE)
    end 
  end

  it "has an empty list of journeys by default" do 
    expect(subject.history).to be_empty
  end

  describe "penalty fares" do 
    it "should give a penalty fare when you don't touch in" do
      subject.touch_out(exit_station)
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-journey.PENALTY_FARE)
    end 

    it "should give a penalty fare when you don't touch out" do 
     expect { subject.touch_in(entry_station) }.to change { subject.balance }.by(-journey.PENALTY_FARE)
    end 

  end
end

end
