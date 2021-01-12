require 'oystercard'

describe Oystercard do

  it { is_expected.to respond_to(:balance) }

  it { is_expected.to respond_to(:top_up).with(1).argument }

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

  it 'should deduct money from balance' do
    expect{ subject.deduct(20)}.to change{ subject.balance }.by -20
  end

  it { is_expected.to respond_to(:touch_in) }

  it 'should touch in oystercard' do
    subject.top_up(5)
    expect(subject.touch_in).to eq (true)
  end 

  it 'should check if oystercard is in_journey?' do
    subject.top_up(5)
    subject.touch_in
    expect(subject.in_journey?).to eq(true)
  end 

  it 'should touch out oystercard' do
    subject.top_up(5)
    subject.touch_in
    expect(subject.touch_out).to eq (false)
  end 

  it 'should raise an error if balance is less than 1' do
    expect { subject.touch_in }.to raise_error "No money"
  end
end

# it 'is initially not in a journey' do
#   expect(subject).not_to be_in_journey
# end 

# it 'can touch in' do 
#   subject.touch_in
#   expect(subject).to be_in_journey
# end 

# it 'can touch out' do
#   subject.touch_in
#   subject.touch_out
#   expect(subject).not_to be_in_journey
# end