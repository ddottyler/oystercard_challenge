require 'oystercard'

describe Oystercard do

  # it "should check a card has a balance" do
  #   expect(subject.balance?).to eq(0)
  # end

  it { is_expected.to respond_to(:balance) }

end
