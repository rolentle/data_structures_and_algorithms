require './spec/spec_helper'

describe Node do
  describe "initialization behavior" do
    subject { Node.new(5) }

    it "should be an instance of a Node" do
      expect(subject).to  be_an_instance_of Node
    end

    it "should accept data and return it" do
      expect(subject.data).to eq 5
    end

    it "can convert input data to node" do
      node = subject.to_node(1)
      expect(node).to be_an_instance_of Node
    end
  end

  context "direct descendant behavior" do
    context  "lesser child behavior" do

      describe "child behavior if not Node" do
	subject { Node.new(5) }
	before { subject.branch 3}
	it "should create a lesser child node when given data" do
	  expect(subject.lesser_child.data).to eq 3
	end
      end

      describe "child behavior if Node" do
	subject { Node.new(5) }
	let(:node2) { Node.new(2) }
	before { subject.branch node2}
	it "should create a lesser child node when given a node" do
	  expect(subject.lesser_child.data).to eq 2
	end
      end
    end

    context "greater child behavior" do
      describe "child behavior if not Node" do
	subject { Node.new(5) }
	before { subject.branch 6}
	it "should create a greater child node when given data" do
	  expect(subject.greater_child.data).to eq 6
	end
      end

      describe "child behavior if Node" do
	subject { Node.new(5) }
	let(:node2) { Node.new(6) }

	it "should create a greater child node when given a node" do
	  subject.branch node2
	  expect(subject.greater_child).to eq node2
	end

      end
    end

    describe "knows the state of its children" do
      subject { Node.new(5) }
      let(:node2) { Node.new(6) }
      before { subject.branch node2}

      it "knows if it has a greater child" do
	expect(subject.greater_child?).to eq true
      end


      it "should know if it doesnt have both children" do
	expect(subject.children_full?).to eq false
      end

      let(:node3) { Node.new(4) }
      it "should know that it has both children" do
	subject.branch node3
	expect(subject.children_full?).to eq true
      end

      it "knows if it has a lesser child" do
	subject.branch node3
	expect(subject.lesser_child?).to eq true
      end
    end
  end

  describe "grandchildren behavior" do
    subject { Node.new(5) }
    let(:gnode) { Node.new(6) }
    let(:lnode) { Node.new(4) }
    before { subject.branch gnode}
    before { subject.branch lnode}

    it "can produce lesser grandchildren" do
      llnode = Node.new(3)
      subject.branch llnode
      expect(subject.lesser_child.lesser_child).to be llnode
    end

    it "can produce greater grandchildren" do
      llnode = Node.new(7)
      subject.branch llnode
      expect(subject.greater_child.greater_child).to be llnode
    end

    it "can produce greater lesser grandchildren" do
      llnode = Node.new(8)
      subject.branch llnode
      glnode = Node.new(7)
      subject.branch glnode

      expect(subject.greater_child.greater_child.lesser_child).to be glnode
    end
  end

  describe "finding children" do
    let(:leaves) { [12, 8, 11, 9, 13] }
    subject { Node.new(10) }
    before :each do
      leaves.each do |leaf|
	subject.branch leaf
      end
    end
    it "can find the root" do
      result = subject.find(10)
      expect(result).to eq subject
    end

    it "can find children" do
      result = subject.find(12)
      expect(result).to eq subject.greater_child
    end

    it "can find grandchildren" do
      result = subject.find(13)
      expect(result).not_to be_nil
    end

    it "can't find non existing intenties" do
      result = subject.find(99)
      expect(result).to be_nil
    end
  end
end
