require "card.rb"

class Deck
  attr_accessor :cards

  def initialize
    @cards = build_deck
  end

  def build_deck
    deck = []
    suits = [:hearts, :spades, :clubs, :diamonds]
    values = (2..14)
    suits.each do |suit|
      values.each do |value|
        deck << Card.new(suit, value)
      end
    end
    deck
  end

  def choose_card(num = 1)
    cards = []
    num.times { cards << @cards.pop }
    cards
  end

  def size
    @cards.size
  end

end