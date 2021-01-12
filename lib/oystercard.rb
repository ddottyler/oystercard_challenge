class Oystercard

  MAXIMUM_BALANCE = 90 

  attr_reader :balance, :in_travel

  def initialize
    @balance = 0
    @in_travel = false
  end

  def top_up(amount)
    fail 'Maximum balance of #{maximum_balance} exceeded' if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end 

  def deduct(amount)
    @balance -= amount
  end

  def touch_in 
    fail "No money" if balance < 1
    @in_travel = true
  end 

  def in_journey?
  @in_travel == true ? true : false
  end
  
  def touch_out
    @in_travel = false
  end

end