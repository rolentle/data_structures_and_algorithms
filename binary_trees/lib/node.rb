class Node
  attr_accessor :data, :lesser_child, :greater_child

  def initialize(data)
    @data = data
  end

  def branch(input)
    input = to_node(input)

    if input.data > data
      if greater_child?
	@greater_child.branch input
      else
        @greater_child = input
      end
    else
      if lesser_child?
	@lesser_child.branch input
      else
        @lesser_child = input
      end
    end
  end

  def find(query)
    query = to_node(query)
    if query.data == data
      return self
    elsif query.data > data
      if greater_child?
	@greater_child.find(query)
      else
	nil
      end
    else
      if lesser_child?
	@lesser_child.find(query)
      else
	nil
      end
    end
  end

  def children_full?
    greater_child? && lesser_child?
  end

  def greater_child?
    !@greater_child.nil?
  end

  def lesser_child?
    !@lesser_child.nil?
  end

  def to_node(input)
    input = Node.new(input) unless input.class == Node
    return input
  end

end
