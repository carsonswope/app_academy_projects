require "deck"
require "rspec"

describe Deck do

  let(:deck) { Deck.new }

  describe "#initialize" do

    it 'makes 52 random cards' do
      expect(deck.cards.length).to eq(52)
    end

    it "populates the deck" do
      expect_any_instance_of(Deck).to receive(:populate)
      Deck.new
    end

  end

  describe "#deal" do

    it 'deals a random card' do
      expect(deck.deal.class).to eq(Card)
    end

    it 'removes the dealt card from the deck' do
      deck.deal
      expect(deck.cards.length).to eq(51)
    end

  end
end
