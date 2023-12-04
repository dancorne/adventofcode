# frozen_string_literal: true

class Day1
  def part1(input)
    input.lines.sum { |line| get_digit(line) }
  end

  def get_digit(line)
    "#{line[/\d/]}#{line.reverse[/\d/]}".to_i
  end

  WORDS_TO_DIGITS = {
    'one' => '1',
    'two' => '2',
    'three' => '3',
    'four' => '4',
    'five' => '5',
    'six' => '6',
    'seven' => '7',
    'eight' => '8',
    'nine' => '9'
  }.freeze

  DIGIT_REGEXP = Regexp.union(WORDS_TO_DIGITS.keys << /\d/)

  def part2(input)
    input.lines.sum { |line| process_line(line) }
  end

  def process_line(line)
    numbers = line.scan(/(?=(#{DIGIT_REGEXP}))/).flatten
    first_match = numbers[0]
    last_match = numbers[numbers.size - 1]
    first = WORDS_TO_DIGITS.fetch(first_match, first_match)
    last = WORDS_TO_DIGITS.fetch(last_match, last_match)
    "#{first}#{last}".to_i
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('./input/day1')
  puts Day1.new.part1(input)
  puts Day1.new.part2(input)
end
