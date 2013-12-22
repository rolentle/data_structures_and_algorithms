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
  end

  describe "lesser child behavior" do

    describe "child behavior if not Node" do
      subject { Node.new(5) }
      before { subject.set_child 3}
      it "should create a lesser child node when given data" do
	expect(subject.lesser_child.data).to eq 3
      end
    end

    describe "child behavior if Node" do
      subject { Node.new(5) }
      let(:node2) { Node.new(2) }
      before { subject.set_child node2}
      it "should create a lesser child node when given a node" do
	expect(subject.lesser_child.data).to eq 2
      end
    end
  end

  describe "greater child behavior" do
    describe "child behavior if not Node" do
      subject { Node.new(5) }
      before { subject.set_child 6}
      it "should create a greater child node when given data" do
	expect(subject.greater_child.data).to eq 6
      end
    end

    describe "child behavior if Node" do
      subject { Node.new(5) }
      let(:node2) { Node.new(6) }
      before { subject.set_child node2}
      it "should create a greater child node when given a node" do
	expect(subject.greater_child.data).to eq 6
      end
    end
  end
end
