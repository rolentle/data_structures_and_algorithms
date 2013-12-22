class Node
  attr_reader :data
  attr_accessor :child, :parent

  def initialize(data)
    @data = data
  end

  def count
    child ? child.count + 1 : 1
  end

  def set_child_parent(node)
    @child = node
    @child.parent = self
  end

  def delete
    if @child
      self.child.parent = self.parent
      self.parent.child = self.child
    else
      self.parent.child = nil
    end
  end

  def last?
    self.child.nil?
  end

  def match?(input)
    data == input
  end

  def match_or_next(input)
    if match?(input)
      return self
    elsif self.child
      self.child.match_or_next(input)
    else
      return nil
    end
  end
end
