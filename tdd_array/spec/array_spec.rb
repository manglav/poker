require 'rspec'
require 'array_exercises'

describe Array do
  subject(:arr) { [-5, -4, -2, -1, 1, 2, 3, 4, 4, 5, 5, 6] }

  describe '#my_uniq' do
    it 'removes duplicates' do
      arr.my_uniq.should == [-5, -4, -2, -1, 1, 2, 3, 4, 5, 6]
    end
  end

  describe '#two_sum' do
    it 'finds indices of values that sum to zero' do
      arr.two_sum.should == [[0, 9], [1, 7], [2, 5], [3, 4]]
    end
  end


  describe '#my_transpose' do
    it 'tranposes a matrix' do
      rows = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
      cols = [[0, 3, 6], [1, 4, 7], [2, 5, 8]]
      rows.my_tranpose.should == cols
    end
  end
end

describe Hanoi do
  subject(:hanoi) { Hanoi.new(3) }

  describe '#initialize' do
    it 'has 3 towers and first one has the discs' do
      hanoi.tower1.should == [3, 2, 1]
      hanoi.tower2.size.should == 0
      hanoi.tower3.size.should == 0
    end
  end

  describe '#play' do
    it 'enter a loop and ask us to select a pile, and where to put it' do
      hanoi.should_receive(:puts).with('Tower 1: [3, 2, 1] Tower2: [] Tower 3: []')
      hanoi.should_receive(:puts).with('Please select a source tower.')
      hanoi.should_receive(:puts).with('Please select a target tower.')
      hanoi.should_receive(:gets).exactly(2).times.and_return("1\n", "2\n")
      hanoi.prompt_and_make_move
      hanoi.tower1.should == [3, 2]
      hanoi.tower2.should == [1]
      hanoi.tower3.should == []
    end

    it 'should fail with ArgumentError' do
      hanoi.should_receive(:gets).exactly(2).times.and_return("2\n", "1\n")
      lambda {hanoi.prompt_and_make_move}.should raise_error(ArgumentError)
    end

    it 'should exit with a win condition' do
      hanoi.should_receive(:gets).exactly(14).times.and_return("1\n", "3\n", "1\n", "2\n", "3\n", "2\n", "1\n", "3\n", "2\n", "1\n", "2\n", "3\n", "1\n", "3\n")
      hanoi.should_receive(:puts).exactly(21).times
      hanoi.should_receive(:puts).once.with("You won!")
      hanoi.play
    end


  end






end