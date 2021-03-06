class EventItem
  include Listable
  attr_reader :description, :start_date, :end_date
  
  def initialize(description, options={})
    @description = description
    @start_date = date_format(options[:start_date]) if options[:start_date]
    @end_date = date_format(options[:end_date]) if options[:end_date]
  end


  def details
    "(Event) " + format_description + "event dates: " + format_date
  end
end
