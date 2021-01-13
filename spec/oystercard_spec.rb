require 'oystercard'

describe Oystercard do

  let(:station){double :station}

  it "should check a card has a balance" do
    expect(subject.balance).to eq(0)
  end

  it "should top up balance" do
    expect{ subject.top_up(20) }.to change{ subject.balance }.by 20
  end

  it 'raises an error if the maximum balance is exceeded' do
    maximum_balance = Oystercard::MAXIMUM_BALANCE 
    subject.top_up(maximum_balance)
    expect{ subject.top_up 1 }.to raise_error 'Maximum balance of #{maximum_balance} exceeded'
  end 

  describe '#touch_in' do
  it { is_expected.to respond_to(:touch_in).with(1).argument }
  it 'should touch in oystercard' do
    subject.top_up(5)
    subject.touch_in(entry_station)
    expect(subject.in_journey?).to eq (true)
  end 
end

  it 'should check if oystercard is in_journey?' do
    subject.top_up(5)
    subject.touch_in(entry_station)
    expect(subject.in_journey?).to eq(true)
  end 

  it 'should touch out oystercard' do
    subject.top_up(5)
    subject.touch_in(entry_station)
    subject.touch_out
    expect(subject.in_journey?).to eq (false)
  end 

  it 'should raise an error if balance is less than 1' do
    expect { subject.touch_in(entry_station) }.to raise_error "No money"
  end

  it 'should take off minimum cost when touching out' do
    subject.top_up(5)
    subject.touch_in(entry_station)
    expect { subject.touch_out }.to change { subject.balance }.by(-Oystercard::MINIMUM_CHARGE)
  end 

end
