require 'minitest/autorun'
require_relative 'day7'

class Day7Test < Minitest::Test
  def test_part1
    input = <<~INPUT
      32T3K 765
      T55J5 684
      KK677 28
      KTJJT 220
      QQQJA 483
    INPUT
    assert_equal 6440, Day7.new(input).part1
  end

  def test_part2
    input = <<~INPUT
      32T3K 765
      T55J5 684
      KK677 28
      KTJJT 220
      QQQJA 483
    INPUT
    assert_equal 5905, Day7.new(input).part2
  end
end
