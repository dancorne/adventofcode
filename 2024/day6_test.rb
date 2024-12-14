# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day6'

class Day6Test < Minitest::Test
  INPUT = <<~INPUT
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#..^.....
    ........#.
    #.........
    ......#...
  INPUT

  def test_parse
    output = [
      %w[. . . . # . . . . .],
      %w[. . . . . . . . . #],
      %w[. . . . . . . . . .],
      %w[. . # . . . . . . .],
      %w[. . . . . . . # . .],
      %w[. . . . . . . . . .],
      %w[. # . . ^ . . . . .],
      %w[. . . . . . . . # .],
      %w[# . . . . . . . . .],
      %w[. . . . . . # . . .]
    ]
    assert_equal output, Day6.new(INPUT).map
  end

  def test_find_guard
    assert_equal [4, 6], Day6.new(INPUT).find_guard
  end

  def test_part1
    assert_equal 41, Day6.new(INPUT).part1
  end
end
