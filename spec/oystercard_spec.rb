require 'oystercard'
require "journey"

describe Oystercard do

  let(:entry_station){double :station}
  let(:exit_station){double :station}
  let(:journey) { double :journey, MINIMUM_FARE: 1, PENALTY_FARE: 6  }

  it "should check a card has a balance" do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
 
    it "should top up balance" do
      expect{ subject.top_up(20) }.to change{ subject.balance }.by 20
    end

    it 'raises an error if the maximum balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE 
      subject.top_up(maximum_balance)
      expect{ subject.top_up 1 }.to raise_error 'Maximum balance of #{maximum_balance} exceeded'
    end 

  end 

  describe '#touch_in' do

    it { is_expected.to respond_to(:touch_in).with(1).argument }
    
    it 'should touch in oystercard' do
      subject.top_up(5)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq (true)
    end 

    it 'should raise an error if balance is less than 1' do
      expect { subject.touch_in(entry_station) }.to raise_error "No money"
    end

  end

  describe "#in_journey" do

    it 'should check if oystercard is in_journey?' do
      subject.top_up(5)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq(true)
    end

    it 'no longer in_journey after touch out' do
      subject.top_up(5)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to eq (false)
    end 
    
  end

  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out).with(1).argument}
    
    it 'should touch out oystercard' do
      subject.top_up(5)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.history.length).to eq 1
    end

    # it 'create a Journey in history' do
    #   subject.top_up(5)
    #   subject.touch_in(entry_station)
    #   subject.touch_out(exit_station)

    #   expect(subject.history).to include journey
    # end


    it 'should take off minimum cost when touching out' do
      subject.top_up(5)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-journey.MINIMUM_FARE)
    end 

  end

  it "has an empty list of journeys by default" do 
    expect(subject.history).to be_empty
  end
  
  it 'should create one journey' do 
    expect(subject).to respond_to :history
  end

  describe "penalty fares" do 
    it "should give a penalty fare when you don't touch in" do
      subject.top_up(10)
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-journey.PENALTY_FARE)
    end 

    it "should give a penalty fare when you don't touch out" do 
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect { subject.touch_in(entry_station) }.to change { subject.balance }.by(-journey.PENALTY_FARE)
    end 

  end 

end
