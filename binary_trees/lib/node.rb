class Node
  attr_accessor :data, :lesser_child, :greater_child

  def initialize(data)
    @data = data
  end

  def set_child(input)
    input = Node.new(input) unless input.class == Node
    if input.data > data
       @greater_child = input
    elsif
      @lesser_child = input
    end
  end
end
