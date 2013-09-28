class Card
  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def <=>(other_card)
    @value <=> other_card.value
  end

  def to_s
    "#{self.class.value_to_s(@value)} of #{@suit.to_s}"
  end

  def self.value_to_s(value)
    case value
    when 2..10 then value.to_s
    when 11 then "Jack"
    when 12 then "Queen"
    when 13 then "King"
    when 14 then "Ace"
    end
  end
end