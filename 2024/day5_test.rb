# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day5'

class Day5Test < Minitest::Test
  INPUT = <<~INPUT
    47|53
    97|13
    97|61
    97|47
    75|29
    61|13
    75|53
    29|13
    97|29
    53|29
    61|53
    97|53
    61|29
    47|13
    75|47
    97|75
    47|61
    75|61
    47|29
    75|13
    53|13

    75,47,61,53,29
    97,61,53,29,13
    75,29,13
    75,97,47,61,53
    61,13,29
    97,13,75,29,47
  INPUT

  def test_parse_updates
    updates = [
      %w[75 47 61 53 29],
      %w[97 61 53 29 13],
      %w[75 29 13],
      %w[75 97 47 61 53],
      %w[61 13 29],
      %w[97 13 75 29 47]
    ]
    assert_equal updates, Day5.new(INPUT).updates
  end

  def test_parse_ordering_rules
    ordering_rules = {
      '47' => %w[53 13 61 29]
    }
    assert_equal ordering_rules['47'], Day5.new(INPUT).ordering_rules['47']
  end

  def test_sort1
    assert_equal %w[75 47 61 53 29], Day5.new(INPUT).sort(%w[75 47 61 53 29])
  end

  def test_sort2
    assert_equal %w[97 75 47 61 53], Day5.new(INPUT).sort(%w[75 97 47 61 53])
  end

  def test_part1
    assert_equal 143, Day5.new(INPUT).part1
  end

  def test_part2
    assert_equal 123, Day5.new(INPUT).part2
  end
end
