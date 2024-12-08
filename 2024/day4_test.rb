# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day4'

class Day4Test < Minitest::Test
  INPUT = <<~INPUT
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
  INPUT

  def test_parse
    output = [
      %w[M M M S X X M A S M],
      %w[M S A M X M S M S A],
      %w[A M X S X M A A M M],
      %w[M S A M A S M S M X],
      %w[X M A S A M X A M M],
      %w[X X A M M X X A M A],
      %w[S M S M S A S X S S],
      %w[S A X A M A S A A A],
      %w[M A M M M X M M M M],
      %w[M X M X A X M A S X]
    ]

    assert_equal output, Day4.new(INPUT).parse(INPUT)
  end

  def test_across
    output = 'MMMSXXMASM'
    assert_equal output, Day4.new(INPUT).crossword_across[0]
  end

  def test_down
    output = 'MMAMXXSSMM'
    assert_equal output, Day4.new(INPUT).crossword_down[0]
  end

  def test_negative_diagonal
    output = 'MSXMAXSAMX'
    assert_equal output, Day4.new(INPUT).crossword_negative_diagonal[9]
  end

  def test_positive_diagonal
    output = 'MAXMMMMASM'
    assert_equal output, Day4.new(INPUT).crossword_positive_diagonal[9]
  end

  def test_part1
    assert_equal 18, Day4.new(INPUT).part1
  end
end
