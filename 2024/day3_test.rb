# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day3'

class Day3Test < Minitest::Test
  INPUT = 'xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))'
  PART2_INPUT = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

  def test_parse
    output = [%w[mul 2 4], %w[mul 5 5], %w[mul 11 8], %w[mul 8 5]]

    assert_equal output, Day3.new(INPUT).instructions
  end

  def test_part1
    assert_equal 161, Day3.new(INPUT).part1
  end

  def test_part2
    assert_equal 48, Day3.new(PART2_INPUT).part2
  end
end
