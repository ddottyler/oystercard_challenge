require_relative 'station'
require_relative 'journey'
class Oystercard
  
  MAXIMUM_BALANCE = 90 

  MINIMUM_CHARGE = 1

  attr_reader :balance, :entry_station, :history, :exit_station, :new_journey
  public
 
  def initialize
    @balance = 0
    @history = {}
    @journey_counter = 1 
  end

  def top_up(amount)
    fail 'Maximum balance of #{maximum_balance} exceeded' if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end 

  def in_journey?
    @in_journey
  end
  
  def touch_in(entry_station) 
    fail "No money" if balance < MINIMUM_CHARGE
    @entry_station = entry_station
    @new_journey = Journey.new(entry_station)
    @in_journey = true 
    end 

  def touch_out(exit_station)
    deduct(MINIMUM_CHARGE)
    @new_journey.end_journey(exit_station)
    @history[@journey_counter] = @new_journey.start_station, @new_journey.end_station
    @journey_counter += 1
    @in_journey = false 
  end 

  private

  def deduct(amount)
    @balance -= amount
  end

end 
 