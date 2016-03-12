class Hand
  attr_reader :cards

  def initialize(cards = [])
    @cards = cards
  end

  def best_combination
    return straight_flush if straight_flush
    return four if four
    return full_house if full_house
    return flush if flush
    return straight if straight
    return three_of_a_kind if three_of_a_kind
    return two_pair if two_pair
    return one_pair if one_pair
    return high_card
  end

  def flush?
    (1..4).any? do |suit|
      @cards.map { |card| card.suit }.count(suit) == 5
    end
  end

  def straight?
    sorted_card_values = @cards.map { |card| card.value }.sort
    (sorted_card_values.min..(sorted_card_values.min+4)).to_a == sorted_card_values
  end

  def straight_flush
    return false unless flush? && straight?
    [8, find_high_card_value]
  end

  def four
    @cards.each do |card|
      if count_of_a_value(card.value) == 4
        return [7, card.value]
      end
    end
    false
  end

  def full_house
    count_hash = Hash.new(0)
    @cards.each do |card|
      count_hash[card.value] += 1
    end
    three_count = nil
    two_count = nil
    count_hash.each do |value, count|
      three_count = value if count == 3
      two_count = value if count == 2
    end
    (two_count && three_count) ? [6, three_count] : false
  end

  def flush
    return false unless flush?
    [5] + @cards.map { |card| card.value }.sort { |v1, v2| v2 <=> v1 }
  end

  def straight
    return false unless straight?
    [4, find_high_card_value]
  end

  def three_of_a_kind
    @cards.each do |card|
      if count_of_a_value(card.value) == 3
        return [3, card.value]
      end
    end
    false
  end

  def two_pair
  end

  def one_pair
  end

  def high_card
  end

  def count_of_a_value(value)
    @cards.map { |card| card.value }.count(value)
  end

  def find_high_card_value(cards = @cards)
    @cards.map { |card| card.value }.max
  end

end
