class JourneyLog

  attr_reader :journey_list

  def initialize
    @journey_list = []
  end


  def start_journey(entry_station)
    @entry_station = entry_station 
  end 
  
  def in_journey?
    @entry_station == nil ? false : true
  end

  def end_journey(exit_station)
    @journey_list << "journey object will go here"
    @entry_station = nil
  end

end 