require 'oystercard'

describe Oystercard do

  oystercard = Oystercard.new

  it { is_expected.to respond_to(:balance) }

  it { is_expected.to respond_to(:top_up).with(1).argument }

  it "should check a card has a balance" do
    expect(oystercard.balance).to eq(0)
  end

  it "should top up balance" do
    expect{ oystercard.top_up(20) }.to change{ oystercard.balance }.by 20
  end

  it 'raises an error if the maximum balance is exceeded' do
    maximum_balance = Oystercard::MAXIMUM_BALANCE 
    subject.top_up(maximum_balance)
    expect{ subject.top_up 1 }.to raise_error 'Maximum balance of #{maximum_balance} exceeded'
  end 

end
