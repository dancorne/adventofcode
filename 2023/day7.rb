# frozen_string_literal: true

class Day7
  def initialize(input)
    @hands = input.lines.map(&:chomp)
  end

  def stronger_hand?(hand, hand_to_compare)
    cards = %w[2 3 4 5 6 7 8 9 T J Q K A].freeze

    score = hand_score(hand)
    comparison = hand_score(hand_to_compare)
    return score > comparison if score != comparison

    hand.chars.each_with_index do |card, idx|
      return cards.index(card) > cards.index(hand_to_compare[idx]) if card != hand_to_compare[idx]
    end
  end

  def hand_score(hand)
    groups = hand.chars.tally
    if groups.values.include?(5)
      6
    elsif groups.values.include?(4)
      5
    elsif groups.values.include?(3) && groups.values.include?(2)
      4
    elsif groups.values.include?(3)
      3
    elsif groups.values.count(2) == 2
      2
    elsif groups.values.include?(2)
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

  def part2
    results = [@hands[0]]
    @hands[1..].each do |hand|
      position = results.index { |result| !part2_stronger_hand?(hand.split[0], result.split[0]) }
      position = -1 if position.nil? # If we get nil, the hand is strongest and should go at the end
      results.insert(position, hand)
    end
    calculate_winnings(results)
  end

  def part2_stronger_hand?(hand, hand_to_compare)
    cards = %w[J 2 3 4 5 6 7 8 9 T Q K A].freeze

    score = part2_hand_score(hand)
    comparison = part2_hand_score(hand_to_compare)
    return score > comparison if score != comparison

    hand.chars.each_with_index do |card, idx|
      return cards.index(card) > cards.index(hand_to_compare[idx]) if card != hand_to_compare[idx]
    end
  end

  def part2_hand_score(hand)
    groups = hand.chars.tally
    j_count = groups.delete('J')
    counts = groups.values.sort.reverse
    # You're always going to get a better score if the J is included with the most frequent card
    counts[0] = if counts.empty?
                  j_count
                else
                  j_count ? counts[0] + j_count : counts[0]
                end

    if counts.include?(5)
      6
    elsif counts.include?(4)
      5
    elsif counts.include?(3) && counts.include?(2)
      4
    elsif counts.include?(3)
      3
    elsif counts.count(2) == 2
      2
    elsif counts.include?(2)
      1
    else
      0
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('./input/day7')
  puts Day7.new(input).part1
  puts Day7.new(input).part2
end
