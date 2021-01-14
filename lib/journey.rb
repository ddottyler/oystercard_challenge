require_relative 'oystercard'

class Journey

  attr_reader :start_station, :end_station

  def initialize(entry_station)
    @start_station = entry_station
    @end_station = nil
  end 

  def end_journey(station)
    @end_station = station 
  end 
  
  def fare
  end

  def complete?
  end 

end 
