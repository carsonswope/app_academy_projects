require 'player'

describe Player do
  pot = double
  let(:player) {Player.new(pot)}

  describe '#hand' do
    it "returns array of cards in hand" do
      expect(player.hand.class).to eq(Array)
    end
  end

  describe '#pot' do
    it "returns amount of dinero" do
      expect(player.pot.class).to eq(Fixnum)
    end
  end

  describe '#swap_cards' do
    it "sets default number of cards to swap to zero" do

    end

    it "accepts a list of card objects to swap" do

    end

    it "raises error for list larger than three cards" do

    end

  end

  describe '#prompt' do

  end

  describe '#fold' do

  end

  describe '#see' do

  end

  describe '#raise' do

  end


end
