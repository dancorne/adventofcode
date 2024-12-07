# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day2'

class Day2Test < Minitest::Test
  INPUT = <<~INPUT
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
  INPUT

  def test_parse
    output = [
      [7, 6, 4, 2, 1],
      [1, 2, 7, 8, 9],
      [9, 7, 6, 2, 1],
      [1, 3, 2, 4, 5],
      [8, 6, 4, 4, 1],
      [1, 3, 6, 7, 9]
    ]

    assert_equal output, Day2.new(INPUT).reports.map(&:levels)
  end

  def test_safe
    assert_equal true, Day2.new(INPUT).reports[0].safe?
    assert_equal true, Day2.new(INPUT).reports[5].safe?
  end

  def test_unsafe_large_increase
    assert_equal false, Day2.new(INPUT).reports[1].safe?
  end

  def test_unsafe_large_decrease
    assert_equal false, Day2.new(INPUT).reports[2].safe?
  end

  def test_unsafe_change_direction
    assert_equal false, Day2.new(INPUT).reports[3].safe?
  end

  def test_unsafe_no_change
    assert_equal false, Day2.new(INPUT).reports[4].safe?
  end

  def test_part1
    assert_equal 2, Day2.new(INPUT).part1
  end

  def test_part2_results
    assert_equal [true, false, false, true, true, true], Day2.new(INPUT).reports.map(&:part2_safe?)
  end

  def test_part2_another_result
    input = '2 1 3 4 5'
    assert_equal [true], Day2.new(input).reports.map(&:part2_safe?)
  end

  def test_part2
    assert_equal 4, Day2.new(INPUT).part2
  end
end
