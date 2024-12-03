require 'minitest/autorun'
require_relative 'day1'

class Day1Test < Minitest::Test
  def test_parse
    input = <<~INPUT
      3   4
      4   3
      2   5
      1   3
      3   9
      3   3
    INPUT
    left = [3, 4, 2, 1, 3, 3]
    right = [4, 3, 5, 3, 9, 3]

    assert_equal left, Day1.new(input).left
    assert_equal right, Day1.new(input).right
  end

  def test_part1
    input = <<~INPUT
      3   4
      4   3
      2   5
      1   3
      3   9
      3   3
    INPUT

    assert_equal 11, Day1.new(input).part1
  end

  def test_part2
    input = <<~INPUT
      3   4
      4   3
      2   5
      1   3
      3   9
      3   3
    INPUT

    assert_equal 31, Day1.new(input).part2
  end
end
