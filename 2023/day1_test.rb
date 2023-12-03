require 'minitest/autorun'
require_relative 'day1'

class Day1Test < Minitest::Test
  def test_part1
    input = <<~INPUT
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
    INPUT
    assert_equal 142, Day1.new.part1(input)
  end

  def test_part2
    input = <<~INPUT
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
    INPUT
    assert_equal 281, Day1.new.part2(input)
  end

  def test_process_line
    input = <<~INPUT
      two1nine
    INPUT
    assert_equal 29, Day1.new.process_line(input)
  end

  def test_process_line_another
    input = <<~INPUT
      eightwothree
    INPUT
    assert_equal 83, Day1.new.process_line(input)
  end
end
