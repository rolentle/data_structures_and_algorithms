require './spec/spec_helper'

describe BinaryTree do
  describe "can preform search" do
    subject { BinaryTree.new(11,9, 8,10) }
    let(:answer) { subject.find(11) }

    it "returns a node when it searches" do
      expect(answer).to be_an_instance_of Node
    end

    it "return node data is 11" do
      expect(answer.data).to be 11
    end

    it "can search for children" do
      answer = subject.find(9)
      expect(answer.data).to be 9
    end

    it "can search for grandchildren" do
      answer = subject.find(10)
      expect(answer.data).to be 10
    end

    it "returns nil if no available" do
      answer = subject.find(100)
      expect(answer).to be_nil
    end
  end
end
