class Deck
  attr_reader :cards

  def initialize
    @cards = populate
  end

  def populate
    cards = []
    (2..14).each do |value|
      (1..4).each do |suit|
        cards << Card.new(value, suit)
      end
    end
    cards.shuffle
  end

  def deal
    @cards.pop
  end


end
