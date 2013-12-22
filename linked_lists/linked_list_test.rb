gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/iterative_linked_list'

class IterativeLinkedListTest < Minitest::Test
  attr_reader :list

  def setup
    @list = IterativeLinkedList.new
  end

  def test_it_starts_with_zero_elements
    assert_equal 0, list.count
  end

  def test_it_can_add_an_element_onto_a_list
    list.push("hello")
    assert_equal 1, list.count
  end

  def test_it_can_add_two_element_onto_a_list
    list.push("hello")
    list.push("world")
    assert_equal 2, list.count
  end

  def test_it_knows_last_element_on_the_list
    list.push("hello")
    list.push("world")
    assert_equal "world", list.last.data
  end

  def test_it_pops_the_last_element_from_the_list
    list.push("hello")
    list.push("world")
    list.push("today")
    output = list.pop
    assert_equal "today", output
    assert_equal 2, list.count
  end

  def test_a_popped_element_is_removed
    list.push("hello")
    output = list.pop
    assert_equal "hello", output
    assert_equal 0, list.count
  end

  def test_it_pops_nil_when_there_are_no_elements
    assert_nil list.pop
  end

  def test_it_deletes_a_solo_node
    list.push("hello")
    list.delete("hello")
    assert_equal 0, list.count
  end

  def test_it_does_not_delete_when_the_data_does_not_match
    list.push("hello")
    list.push("world")
    list.delete("today")
    assert_equal 2, list.count
  end

  def test_it_deletes_a_last_node
    list.push("hello")
    list.push("world")
    list.push("today")
    list.delete("today")
    assert_equal 2, list.count
  end

  def test_it_deletes_a_middle_node
    list.push("hello")
    list.push("world")
    list.push("today")
    list.delete("world")
    assert_equal 2, list.count
    assert_equal "today", list.pop
    assert_equal "hello", list.pop
  end

  def test_it_deletes_the_head_when_there_are_more_nodes
    list.push("hello")
    list.push("world")
    list.push("today")
    list.delete("hello")
    assert_equal 2, list.count
    assert_equal "today", list.pop
    assert_equal "world", list.pop
  end

  def test_it_converts_to_an_array_when_there_are_no_elements
    assert_equal [], list.to_a
  end

  def test_it_converts_to_an_array_with_several_elements
    list.push("hello")
    list.push("world")
    list.push("today")
    assert_equal ["hello", "world", "today"], list.to_a
  end

  def test_it_finds_the_last_node
    list.push("hello")
    list.push("world")
    node = list.last_node
    assert_equal "world", node.data
  end
end

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
