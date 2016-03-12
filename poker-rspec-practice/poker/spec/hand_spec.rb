require 'hand'

describe Hand do

  def assemble_cards(list)
    list.map { |card| Card.new(*card) }
  end

  four_of_a_kind_cards =  [[6, 1], [6, 2], [6, 3], [6, 4], [11, 2]]
  full_house_cards =      [[5, 1], [5, 2], [5, 4], [13,2], [13, 3]]
  flush_cards =           [[3, 4], [4, 4], [5, 4],[10, 4], [11, 4]]
  one_pair_cards =        [[7, 1], [7, 4],[13, 1], [4, 2], [ 3, 1]]
  one_pair_cards_loser =  [[7, 3], [7, 2],[13, 2], [4, 3], [ 2, 4]]
  royal_flush_cards =     [[14,1], [13,1],[12, 1], [11,1], [10, 1]]
  straight_cards =        [[8, 2], [7, 2], [6, 3], [5, 4], [ 4, 1]]

  let(:straight_hand) { Hand.new(assemble_cards(straight_cards))}
  let(:four_of_a_kind_hand) { Hand.new(assemble_cards(four_of_a_kind_cards)) }
  let(:full_house_hand) { Hand.new(assemble_cards(full_house_cards)) }
  let(:flush_hand) { Hand.new(assemble_cards(flush_cards)) }
  let(:one_pair_hand) { Hand.new(assemble_cards(one_pair_cards)) }
  let(:one_pair_hand_loser) { Hand.new(assemble_cards(one_pair_cards_loser)) }
  let(:royal_flush_hand) { Hand.new(assemble_cards(royal_flush_cards))}

  describe "#best_combination" do
    it 'finds a royal flush' do
      expect(royal_flush_hand.best_combination).to eq([8, 14])
    end

    it 'finds a four of a kind' do
      expect(four_of_a_kind_hand.best_combination).to eq([7, 6])
    end

    it 'finds a full house' do
      expect(full_house_hand.best_combination).to eq([6, 5])
    end

    it 'finds a flush' do
      expect(flush_hand.best_combination).to eq([5, 11, 10, 5, 4, 3])
    end

    it 'finds a straight' do
      expect(straight_hand.best_combination).to eq([4, 8])
    end

    it 'finds a one pair' do
      expect(one_pair_hand.best_combination).to eq([1, 7, 13, 4, 3])
    end
  end

  describe "::compare_hands" do

    it 'determines winning hand among two hands' do
      expect(Hand.compare_hands(flush_hand, one_pair_hand)).to eq(flush_hand)
    end

    it 'breaks a close tie' do
      expect(Hand.compare_hands(one_pair_hand, one_pair_hand_loser)).to eq(one_pair_hand)
    end

    it 'determines winning hand among three hands' do
      expect(Hand.compare_hands(flush_hand, one_pair_hand, four_of_a_kind_hand)).to eq(four_of_a_kind_hand)
    end

  end
end
