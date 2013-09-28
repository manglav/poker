require "rspec"
require "card"
require "deck"
require "hand"

describe Card do
  subject(:card) { Card.new(:hearts, 12) }

  describe "#initialize" do
    it "initializes to the 8 of hearts" do
      expect(card.suit).to eq :hearts
      expect(card.value).to be 12
      expect(card.to_s).to eq "Queen of hearts"
    end
  end

  describe "#<=>" do
    it "is greater than 6 and less than king" do
      card0 = double("card0", :suit => :hearts, :value => 6)
      card1 = double("card1", :suit => :hearts, :value => 13)

      expect(card.<=>(card0)).to be 1
      expect(card.<=>(card1)).to be -1
    end
  end
end

describe Deck do
  subject(:deck) { Deck.new }

  describe "#initialize" do
    it "initializes to a 52-card deck with 13 of each suit" do
      expect(deck.size).to be 52
      expect(deck.cards.select { |card| card.suit == :hearts }.size).to be 13
    end
  end

  describe "#choose_card" do
    it "returns a random card" do
      card = deck.choose_card(1)[0]
      expect(deck.size).to be  51
      expect(card.value).to be >= 1
      expect(card.value).to be <= 14
    end
  end
end

describe Hand do
  subject(:hand) do
    card0 = double("card0", :suit => :hearts, :value => 10)
    card1 = double("card1", :suit => :hearts, :value => 11)
    card2 = double("card2", :suit => :hearts, :value => 12)
    card3 = double("card3", :suit => :hearts, :value => 13)
    card4 = double("card4", :suit => :hearts, :value => 14)
    Hand.new(card0, card1, card2, card3, card4)
  end

  describe "#initialize" do
    it "initializes to 5 cards" do
      expect(hand.cards.size).to eq 5
    end
  end

  describe "#rank" do
    it "works for straight flush" do
      let(:hand) do
        card0 = double("card0", :suit => :hearts, :value => 10)
        card1 = double("card1", :suit => :hearts, :value => 11)
        card2 = double("card2", :suit => :hearts, :value => 12)
        card3 = double("card3", :suit => :hearts, :value => 13)
        card4 = double("card4", :suit => :hearts, :value => 14)
        Hand.new(card0, card1, card2, card3, card4)
      end
      expect(hand.rank).to eq ({rank: 8, high: 14, kicker: []})
    end

    it "works for four of a kind" do
      subject do
        card0 = double("card0", :suit => :hearts, :value => 10)
        card1 = double("card1", :suit => :spades, :value => 10)
        card2 = double("card2", :suit => :clubs, :value => 10)
        card3 = double("card3", :suit => :diamonds, :value => 10)
        card4 = double("card4", :suit => :hearts, :value => 14)
        Hand.new(card0, card1, card2, card3, card4)
      end
      expect(hand.rank).to eq ({rank: 7, high: 10, kicker: [14]})
    end

    it "works for full house" do
      subject do
        card0 = double("card0", :suit => :hearts, :value => 10)
        card1 = double("card1", :suit => :spades, :value => 10)
        card2 = double("card2", :suit => :clubs, :value => 10)
        card3 = double("card3", :suit => :diamonds, :value => 13)
        card4 = double("card4", :suit => :hearts, :value => 13)
        Hand.new(card0, card1, card2, card3, card4)
      end
      expect(hand.rank).to eq ({rank: 6, high: 10, kicker: [13]})
    end

    it "works for flush" do
      subject do
        card0 = double("card0", :suit => :hearts, :value => 10)
        card1 = double("card1", :suit => :hearts, :value => 9)
        card2 = double("card2", :suit => :hearts, :value => 8)
        card3 = double("card3", :suit => :hearts, :value => 7)
        card4 = double("card4", :suit => :hearts, :value => 6)
        Hand.new(card0, card1, card2, card3, card4)
      end
      expect(hand.rank).to eq ({rank: 5, high: 10, kicker: []})
    end

    it "works for straight" do
      subject do
        card0 = double("card0", :suit => :hearts, :value => 10)
        card1 = double("card1", :suit => :spades, :value => 9)
        card2 = double("card2", :suit => :clubs, :value => 8)
        card3 = double("card3", :suit => :diamonds, :value => 7)
        card4 = double("card4", :suit => :hearts, :value => 6)
        Hand.new(card0, card1, card2, card3, card4)
      end
      expect(hand.rank).to eq ({rank: 4, high: 10, kicker: []})
    end

    it "works for three of a kind" do
      subject do
        card0 = double("card0", :suit => :hearts, :value => 10)
        card1 = double("card1", :suit => :spades, :value => 10)
        card2 = double("card2", :suit => :clubs, :value => 10)
        card3 = double("card3", :suit => :diamonds, :value => 7)
        card4 = double("card4", :suit => :hearts, :value => 6)
        Hand.new(card0, card1, card2, card3, card4)
      end
      expect(hand.rank).to eq ({rank: 3, high: 10, kicker: [7, 6]})
    end

    it "works for two pair" do
      subject do
        card0 = double("card0", :suit => :hearts, :value => 10)
        card1 = double("card1", :suit => :spades, :value => 10)
        card2 = double("card2", :suit => :clubs, :value => 8)
        card3 = double("card3", :suit => :diamonds, :value => 8)
        card4 = double("card4", :suit => :hearts, :value => 6)
        Hand.new(card0, card1, card2, card3, card4)
      end
      expect(hand.rank).to eq ({rank: 2, high: 10, kicker: [8, 6]})
    end

    it "works for one pair" do
      subject do
        card0 = double("card0", :suit => :hearts, :value => 10)
        card1 = double("card1", :suit => :spades, :value => 10)
        card2 = double("card2", :suit => :clubs, :value => 8)
        card3 = double("card3", :suit => :diamonds, :value => 7)
        card4 = double("card4", :suit => :hearts, :value => 6)
        Hand.new(card0, card1, card2, card3, card4)
      end
      expect(hand.rank).to eq ({rank: 1, high: 10, kicker: [8, 7, 6]})
    end

    it "works for high card" do
      subject do
        card0 = double("card0", :suit => :hearts, :value => 12)
        card1 = double("card1", :suit => :spades, :value => 9)
        card2 = double("card2", :suit => :clubs, :value => 8)
        card3 = double("card3", :suit => :diamonds, :value => 7)
        card4 = double("card4", :suit => :hearts, :value => 6)
        Hand.new(card0, card1, card2, card3, card4)
      end
      expect(hand.rank).to eq ({rank: 0, high: 12, kicker: [9, 8, 7, 6]})
    end
  end
end
=begin
describe Player do
  subject(:player) { Player.new }

  describe "#initialize" do

  end
end

describe Game do
  subject(:game) { Game.new }

  describe "#initialize" do

  end
end

# describe Array do
#   subject(:arr) { [-5, -4, -2, -1, 1, 2, 3, 4, 4, 5, 5, 6] }
#
#   describe '#my_uniq' do
#     it 'removes duplicates' do
#       arr.my_uniq.should == [-5, -4, -2, -1, 1, 2, 3, 4, 5, 6]
#     end
#   end
#
#   describe '#two_sum' do
#     it 'finds indices of values that sum.to zero' do
#       arr.two_sum.should == [[0, 9], [1, 7], [2, 5], [3, 4]]
#     end
#   end
#
#
#   describe '#my_transpose' do
#     it 'tranposes a matrix' do
#       rows = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
#       cols = [[0, 3, 6], [1, 4, 7], [2, 5, 8]]
#       rows.my_tranpose.should == cols
#     end
#   end
# end
=end