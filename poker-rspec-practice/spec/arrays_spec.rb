require 'arrays'
require 'rspec'

describe Array do
  describe '#my_uniq' do

    it "removes duplicates" do
      expect([ 1, 2, 1, 3, 3].my_uniq).to eq([ 1, 2, 3])
    end

    it "returns empty array when called on an empty array" do
      expect([].my_uniq).to eq([])
    end

    it "returns same array when there are no duplicates" do
      expect([1, 2, 3].my_uniq).to eq([1, 2, 3])
    end
  end

  describe '#two_sum' do
    it "finds a pair that sums to zero" do
      expect([-1,0,1].two_sum).to eq([[0,2]])
    end

    it "finds all pairs that sum to zero" do
      expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4],[2, 3]])
    end

    it "doesn't return pairs if there are none" do
      expect([1,2,3,4].two_sum).to eq([])
    end

    it "returns empty array when called on an empty array" do
      expect([].two_sum).to eq([])
    end
  end

  describe '#my_transpose' do
    it 'converts between row oriented and column oriented representations' do
      expect([  [0,1,2],
                [3,4,5],
                [6,7,8]].my_transpose).to eq(

              [ [0,3,6],
                [1,4,7],
                [2,5,8]])
    end

    it 'leaves an empty array the same' do
      expect([].my_transpose).to eq([])
    end

    it 'turns a single row into a column' do
      expect([[0,1,2]].my_transpose).to eq([[0],
                                          [1],
                                          [2]])
    end

    it 'reverts a column into a single row' do
      expect([[0],
              [1],
              [2]].my_transpose).to eq([[0,1,2]])
    end
  end

  describe '#stock_picker' do
    it 'returns the most profitable pair of days to buy then sell' do
      expect([10,12,11,9,15].stock_picker).to eq([3,4])
      expect([10,15,11,9,12].stock_picker).to eq([0,1])
      expect([9,8,7,10,11,15].stock_picker).to eq([2,5])
    end

    it 'returns an empty array if no combinations are profitable' do
      expect([9,8,6,5,4,3].stock_picker).to eq([])
    end

    it "returns empty array when called on an empty array" do
      expect([].stock_picker).to eq([])
    end
  end
end
