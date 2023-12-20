require 'minitest/autorun'
require_relative 'day8'

class Day8Test < Minitest::Test
  def test_part1_two
    input = <<~INPUT
      RL

      AAA = (BBB, CCC)
      BBB = (DDD, EEE)
      CCC = (ZZZ, GGG)
      DDD = (DDD, DDD)
      EEE = (EEE, EEE)
      GGG = (GGG, GGG)
      ZZZ = (ZZZ, ZZZ)
    INPUT
    assert_equal 2, Day8.new(input).part1
  end

  def test_part1_six
    input = <<~INPUT
      LLR

      AAA = (BBB, BBB)
      BBB = (AAA, ZZZ)
      ZZZ = (ZZZ, ZZZ)
    INPUT
    assert_equal 6, Day8.new(input).part1
  end

  def test_part2
    input = <<~INPUT
      LR

      11A = (11B, XXX)
      11B = (XXX, 11Z)
      11Z = (11B, XXX)
      22A = (22B, XXX)
      22B = (22C, 22C)
      22C = (22Z, 22Z)
      22Z = (22B, 22B)
      XXX = (XXX, XXX)
    INPUT
    assert_equal 6, Day8.new(input).part2
  end
end
