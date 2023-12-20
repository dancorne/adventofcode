require 'minitest/autorun'
require_relative 'day9'

class Day9Test < Minitest::Test
  def test_part1
    input = <<~INPUT
      0 3 6 9 12 15
      1 3 6 10 15 21
      10 13 16 21 30 45
    INPUT
    assert_equal 114, Day9.new(input).part1
  end

  def test_part2
    input = <<~INPUT
      0 3 6 9 12 15
      1 3 6 10 15 21
      10 13 16 21 30 45
    INPUT
    assert_equal 2, Day9.new(input).part2
  end
end
