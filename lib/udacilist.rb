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
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
end
