module Listable
  # Listable methods go here
  def format_description
    "#{@description}".ljust(25)
  end
  
  def format_date
    if self.class == EventItem
      dates = @start_date.strftime("%D") if @start_date
      dates << " -- " + @end_date.strftime("%D") if @end_date
      dates = "N/A" if !dates
      return dates
    elsif self.class == TodoItem
      @due ? @due.strftime("%D") : "No due date"
    else
      "Null"
    end
  end
  
  
  def format_priority
    value = " ⇧" if @priority == "high"
    value = " ⇨" if @priority == "medium"
    value = " ⇩" if @priority == "low"
    value = "" if !@priority
    return value
  end
  
end
