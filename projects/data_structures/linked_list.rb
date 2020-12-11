class LinkedList
  attr_accessor :head
  def initialize
    @head = nil
  end

  def append(value)
    error_check
    loop do
      # recursive into the next_node
      if @head == nil
        @head = Node.new(value)
        return
      end

      current_node = @head
      until current_node.next == nil
        current_node = current_node.next
      end
      current_node.next = Node.new(value)
    end
  end

  def prepend(value)
    error_check
    temp = @head
    @head = Node.new(value)
    @head.next = temp
  end

  def size
    error_check
    count = 1
    current_node = @head
    until current_node.next == nil
      current_node = current_node.next
      count = count + 1
    end

    return count
  end

  def head
    error_check

    return @head
  end

  def tail
    error_check

    current_node = @head
    until current_node.next == nil
      current_node = current_node.next
    end

    return current_node
  end

  def at_index(index)
    error_check
    
    current_node = @head
    index.times do
      current_node = current_node.next
    end

    return current_node
  end

  def pop
    @head == nil ? (return 0) : ""
    current_node = @head

    until current_node.next == nil
      current_node = current_node.next
    end

    current_node = nil
  end

  def contains?(value)
    error_check
    
    current_node = @head
    until current_node.next == nil
      current_node.value == value ? (return true) : ""
      current_node = current_node.next
    end

    return false
  end

  def find(value)
    error_check
    count = 0
    current_node = @head
    loop do
      current_node.value == value ? (return count) : ""
      current_node = current_node.next
      count = count + 1

      current_node.next == nil ? next : ""
    end

    return "no matching index"
  end

  def error_check
    @head == nil ? (return 0) : ""
  end

  def to_s
    error_check
    current_node = @head
    until current_node == nil
      
      print " #{current_node.value} ==>"
      current_node = current_node.next

    end
  end
end


class Node
  attr_accessor :value, :next
  def initialize(value = nil)
    @value = value
    @next = nil #next node
  end


end


linked_list = LinkedList.new
linked_list.append(1)
linked_list.prepend(3)

# p linked_list
# p linked_list.size
# p linked_list.head
# p linked_list.tail
# p linked_list.at_index(0)
# p linked_list.contains?(3)
# p linked_list.find(1)
print linked_list.to_s