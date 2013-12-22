gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/node'

class NodeTest < Minitest::Test
  def test_node_knows_if_it_is_last
    node = Node.new("horse")
    node2 = Node.new("car")
    node.child = node2

    refute node.last?
    assert node2.last?
  end

  def test_node_data_matchs
    node = Node.new("horse")
    assert node.match?("horse")
    refute node.match?("house")
  end

  def test_match_or_next_works
    node = Node.new("horse")
    node2 = Node.new("random")
    node.child = node2

    assert node.match_or_next("horse")
  end

  def test_match_or_next_works
    node = Node.new("horse")
    node2 = Node.new("random")
    node.child = node2

    assert node.match_or_next("random")
  end

  def test_match_or_next_works
    node = Node.new("horse")
    node2 = Node.new("random")
    node.child = node2

    refute node.match_or_next("cow")
  end

  def test_node_knows_parent
    node = Node.new("horse")
    node2 = Node.new("random")
    node.set_child_parent(node2)

    assert_equal node, node2.parent
  end

  def test_node_can_pop_self
    node = Node.new("horse")
    node2 = Node.new("random")
    node.set_child_parent(node2)

    node2.delete
    refute node.child
  end

  def test_node_parent_adopts_grandchild_when_deleted
    node = Node.new("1")
    node2 = Node.new("2")
    node.set_child_parent(node2)
    node3 = Node.new("3")
    node2.set_child_parent(node3)

    node2.delete

    assert_equal "3", node.child.data
    refute_equal "2", node.child.data
    refute_equal "2", node3.parent.data
  end

end
