require_relative 'station'
require_relative "journey"

class Oystercard

  MAXIMUM_BALANCE = 90 

  MINIMUM_CHARGE = 1

  attr_reader :balance, :entry_station, :history

  def initialize
    @balance = 0
    @history = []
  end

  def top_up(amount)
    fail 'Maximum balance of #{maximum_balance} exceeded' if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end 

  def touch_in(entry_station) 
    fail "No money" if balance < MINIMUM_CHARGE
    @entry_station = entry_station
    end 

  def in_journey?
    @entry_station == nil ? false : true
  end
  
  def touch_out(exit_station)
    deduct(MINIMUM_CHARGE)
    @history << { entry_station: entry_station, exit_station: exit_station }
    @entry_station = nil
  end 
    

  private

  def deduct(amount)
    @balance -= amount
  end

end