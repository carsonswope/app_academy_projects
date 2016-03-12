require 'rspec'
require 'card'

describe Card do

  let(:card) { Card.new(11, 3) }

  describe '#value' do
    it "returns its own value" do
      expect(card.value).to eq(11)
    end
  end

  describe '#suit' do
    it "returns its own suit" do
      expect(card.suit).to eq(3)
    end
  end

  describe '#to_s' do
    it "stringifies itself" do
      expect(card.to_s).to eq("Jack of Diamonds")
    end
  end

end
