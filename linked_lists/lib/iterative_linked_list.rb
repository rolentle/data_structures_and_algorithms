require './lib/node'

class IterativeLinkedList
  attr_reader :head

  def count
    @head ? @head.count : 0
  end

  def push(data)
    node = Node.new(data)
    @head ? self.last.set_child_parent(node) : @head = node
  end

  def pop
     return nil if @head.nil?

     if @head.last?
       popped_node = @head
       @head = nil
       return popped_node.data
     end

     current_node = @head
     until current_node.last?
       previous_node = current_node
       current_node = previous_node.child
     end

     previous_node.child = nil
     return current_node.data
  end

  def delete(input)
    current_node = @head
    if current_node.match?(input)
      if @head.child
	@head = @head.child
	@head.parent = nil
      else
	@head = nil
      end
      return nil
    end
    current_node = current_node.match_or_next(input)
    current_node.delete if current_node
  end

  def last
    current_node = @head
    current_node = next_node(current_node) until current_node.last?
    return current_node
  end

  def last_node
    last
  end

  def next_node(current_node)
    previous_node = current_node
    current_node = previous_node.child
  end

  def to_a
    array = []
    current_node = @head
    while current_node
      array << current_node.data
      current_node = next_node(current_node)
    end

    return array
  end
end
