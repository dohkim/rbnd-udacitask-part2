class TodoItem
  include Listable
  attr_reader :description, :due, :priority
  PRIORITY = ["high", "medium", "low", nil]
  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Date.parse(options[:due]) : options[:due]
    if PRIORITY.include? options[:priority]
      @priority = options[:priority]
    else
      raise UdaciListErrors::InvalidPriorityValue, "#{options[:priority]} is not available for priority"
    end
  end

  def details
    format_description + "due: " +
    format_date +
    format_priority
  end
end
