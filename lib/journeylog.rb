class JourneyLog

  def start_journey(entry_station)
    @entry_station = entry_station 
  end 
  
  def in_journey?
    @entry_station == nil ? false : true
  end

end 