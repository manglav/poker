require "card"
require "deck"

class Hand
  HANDS = %w[straight_flush four_of_a_kind full_house flush straight three_of_a_kind two_pair one_pair high_card]
  HAND_VALUES = Hash[HANDS.zip((0..8).to_a.reverse)]

  attr_reader :cards

  def initialize(*cards)
    @cards = cards
  end

  def rank
    suits = cards.map { |card| card.suit }
    values = cards.map { |card| card.value }.sort.reverse
    HANDS.each do |hand_check|
      if (rank = send(hand_check, suits, values))
        puts hand_check
        return rank
      end
    end
  end

  def straight_flush(suits, values)
    if suits.uniq.size == 1 && values.each_cons(2).all? { |val1, val2| val1 - val2 == 1 }
      return {rank: HAND_VALUES[__method__.to_s], high: values.max, kicker:[]}
    end
    nil
  end

  def four_of_a_kind(suits, values)
    parts = values.partition { |val| val == values[0] }
    four = parts.detect { |part| part.length == 4}
    kicker = values - four
    if four
      return {rank: HAND_VALUES[__method__.to_s], high: four.first, kicker: kicker}
    end
    nil
  end

  def full_house(suits, values)
    parts = values.partition { |val| val == values[0] }
    three = parts.detect { |part| part.length == 3}
    kicker = parts - three
    if three && kicker.uniq.length == 1
      return {rank: HAND_VALUES[__method__.to_s], high: three.first, kicker: [kicker[0]]}
    end
    nil
  end

  def flush(suits, values)
    if suits.uniq == 1
      return {rank: HAND_VALUES[__method__.to_s], high: values.max , kicker: []}
    end
    nil
  end

  def straight(suits, values)
    if values.each_cons(2).all { |val1, val2| val2 - val1 == 1 }
      return {rank: HAND_VALUES[__method__.to_s], high: values.max, kicker: []}
    end
    nil
  end

  def three_of_a_kind(suits, values)
    three = values.each_cons(3).detect { |val1, val2, val3| val1 == val2 && val2 == val3 }
    if three
      return {rank: HAND_VALUES[__method__.to_s], high: three.first, kicker: values - three}
    end
    nil
  end

  def two_pair(suits, values)
    pairs = []
    values.each_cons(2).each { |val1, val2| pairs << [val1, val2] if val1 == val2 }
    if pairs.length == 2
      return {rank: HAND_VALUES[__method__.to_s], high: pairs.max.first, kicker: [pairs.min.first, values - pairs.flatten]}
    end
    nil
  end

  def one_pair(suits, values)
    pair = values.each_cons(2).detect { |val1, val2| val1 == val2 }
    if pair
      return {rank: HAND_VALUES[__method__.to_s], high: pair.first, kicker: values - pair}
    end
    nil
  end

  def high_card(suits, values)
    {rank: HAND_VALUES[__method__.to_s], high: values.first, kicker: values[1..-1]}
  end

end