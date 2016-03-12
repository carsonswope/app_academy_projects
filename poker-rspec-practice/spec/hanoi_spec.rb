require 'hanoi'
require 'rspec'

describe Hanoi do

  let(:hanoi) { Hanoi.new }

  describe '#render' do

    #STDOUT DOESNT GET PASSED AS A SYMBOL, for more info see http://stackoverflow.com/questions/17709317/how-to-test-puts-in-rspec
    it "renders the towers at the beginning of the game" do
      expect(STDOUT).to receive(:puts).with("Tower 1: 3 2 1\nTower 2: \nTower 3: ")
      hanoi.render
    end

    it "renders the towers at the beginning of the game" do
      expect(STDOUT).to receive(:puts).with("Tower 1: 3 2\nTower 2: 1\nTower 3: ")
      hanoi.move([0,1])
      hanoi.render
    end

  end

  describe '#move' do
    it 'moves a piece from the first tower to the second tower' do
      hanoi.move([0,1])
      expect(hanoi.towers).to eq( [[3,2], [1], []] )
    end

    #USE BLOCK TO TEST RAISED ERRORS
    it 'rejects an invalid move' do
      hanoi.move([0,1])
      expect { hanoi.move([0,1]) }.to raise_error(InvalidMoveError)
    end

    it 'rejects a move out of bounds' do
      expect { hanoi.move([0,3]) }.to raise_error(OutOfBoundsError)
    end
  end

  describe '#won?' do
    it 'detects a win' do
      moves_ary = [[0,2], [0,1], [2,1], [0,2], [1,0], [1,2], [0,2]]
      moves_ary.each { |move_info| hanoi.move(move_info) }
      expect(hanoi.won?).to eq(true)
    end
    it 'detects a win' do
      hanoi.move([0,2])
      hanoi.move([0,1])
      expect(hanoi.won?).to eq(false)
    end
  end
end
