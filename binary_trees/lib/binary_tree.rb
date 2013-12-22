require './lib/node'

class BinaryTree
  attr_reader :root
  def initialize(*args)
    @root = Node.new(args[0])

    args[1..-1].each do |leaf|
      @root.branch leaf
    end
  end

  def find(query)
    @root.find(query)
  end
end
