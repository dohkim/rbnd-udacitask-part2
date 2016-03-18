class UdaciList
  attr_reader :title, :items
  #Table for terminal table
  $rows = []
  

  def initialize(options={})
    options[:title] ||= "Untitled List"  #Set Untitled List if title has no name
    @title = options[:title]
    @items = []
  end
  
  def add(type, description, options={})
    type = type.downcase
    case type
    when "todo" then @items.push TodoItem.new(description, options)
    when "event" then @items.push EventItem.new(description, options)
    when "link" then @items.push LinkItem.new(description, options)
    else raise UdaciListErrors::InvalidItemType, "#{type} is not right type" 
    end
  end
  
  def delete(index)
    if @items.length < index 
      raise UdaciListErrors::IndexExceedsListSize, "No task in ##{index} "
    end
    @items.delete_at(index - 1)
  end
  
  def all
    @items.each_with_index do |item, position|
      $rows << [position + 1 , item.details]
    end
    display_form
  end
  
  def filter(item_type)
    case item_type
    when "todo" then filter = @items.select {|item| item.class == TodoItem }
    when "event" then filter = @items.select {|item| item.class == EventItem }
    when "link" then filter = @items.select {|item| item.class == LinkItem }
    else raise UdaciListErrors::InvalidItemType, "#{item_type} is not right type" 
    end  
    filter.each_with_index do |item, position|
       $rows << [position + 1 , item.details ]
    end
    display_form
  end
  
  def change_priority(index, priority)
    raise UdaciListErrors::InvalidItemType, "#{@items[index-1].class} has no priority" if @items[index-1].class != TodoItem
    @items[index-1].priority_change(priority)
  end
  
  
  def display_form
    table = Terminal::Table.new :title => @title, :headings => ["#","Description"], :rows => $rows
    puts table
    $rows=[]
    puts
  end
  
end
