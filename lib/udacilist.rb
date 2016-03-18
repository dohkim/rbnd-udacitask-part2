class UdaciList
  attr_reader :title, :items

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
    display_form
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
  
  def filter(item_type)
    case item_type
    when "todo" then filter = @items.select {|item| item.class == TodoItem }
    when "event" then filter = @items.select {|item| item.class == EventItem }
    when "link" then filter = @items.select {|item| item.class == LinkItem }
    else raise UdaciListErrors::InvalidItemType, "#{item_type} is not right type" 
    end  
    display_form
    puts "Search #{item_type}"
    filter.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
  
  def display_form
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
  end
  
end
