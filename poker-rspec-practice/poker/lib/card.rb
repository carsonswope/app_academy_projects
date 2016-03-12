class Card

  attr_accessor :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def to_s
    "#{value_hash[@value]} of #{suit_hash[@suit]}"
  end

  def suit_hash
    {
      1 => "Spades",
      2 => "Clubs",
      3 => "Diamonds",
      4 => "Hearts"
    }
  end

  def value_hash
    {
      2 => "Two",
      3 => "Three",
      4 => "Four",
      5 => "Five",
      6 => "Six",
      7 => "Seven",
      8 => "Eight",
      9 => "Nine",
      10 => "Ten",
      11 => "Jack",
      12 => "Queen",
      13 => "King",
      14 => "Ace",
    }
  end
end
