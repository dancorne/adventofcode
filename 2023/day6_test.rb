require 'minitest/autorun'
require_relative 'day6'

class Day6Test < Minitest::Test
  def test_part1
    input = <<~INPUT
      Time:      7  15   30
      Distance:  9  40  200
    INPUT
    assert_equal 288, Day6.new(input).part1
  end
end
