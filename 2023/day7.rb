# frozen_string_literal: true

class Day7
  CARDS = %w[2 3 4 5 6 7 8 9 T J Q K A].freeze

  def initialize(input)
    @hands = input.lines.map(&:chomp)
  end

  def stronger_hand?(hand, hand_to_compare)
    score = hand_score(hand)
    comparison = hand_score(hand_to_compare)
    return score > comparison if score != comparison

    hand.chars.each_with_index do |card, idx|
      return CARDS.index(card) > CARDS.index(hand_to_compare[idx]) if card != hand_to_compare[idx]
    end
  end

  def hand_score(hand)
    case hand.chars.sort.join
    when /(.)\1{4}/
      6
    when /(.)\1{3}/
      5
    when /(.)\1\1(.)\2|(.)\1(.)\2\2/
      4
    when /(.)\1\1/
      3
    when /(.)\1.?(.)\2/
      2
    when /(.)\1/
      1
    else
      0
    end
  end

  def calculate_winnings(hands)
    hands.each_with_index.sum do |hand, idx|
      hand.split[1].to_i * (idx + 1)
    end
  end

  def part1
    results = [@hands[0]]
    @hands[1..].each do |hand|
      position = results.index { |result| !stronger_hand?(hand.split[0], result.split[0]) }
      position = -1 if position.nil? # If we get nil, the hand is strongest and should go at the end
      results.insert(position, hand)
    end
    calculate_winnings(results)
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('./input/day7')
  puts Day7.new(input).part1
  # puts Day7.new(input).part2
end
