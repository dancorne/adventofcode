require 'minitest/autorun'
require_relative 'day3'

class Day3Test < Minitest::Test
  def test_part1
    skip
    input = <<~INPUT
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
    INPUT
    assert_equal 4361, Day3.new(input).part1
  end

  def test_find_symbols
    input = <<~INPUT
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
    INPUT
    assert_equal [[1, 3], [3, 6], [4, 3], [5, 5], [8, 3], [8, 5]], Day3.new(input).find_symbols
  end
end
