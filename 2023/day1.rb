# frozen_string_literal: true

class Day1
  def part1(input)
    input.lines.sum { |line| get_digit(line) }
  end

  def get_digit(line)
    "#{line[/\d/]}#{line.reverse[/\d/]}".to_i
  end

  def part2(input)
    input.lines.sum { |line| process_line(line) }
  end

  def process_line(line)
    "#{word_to_digit(line)[/\d/]}#{word_to_digit(line).reverse[/\d/]}".to_i
  end

  def word_to_digit(line)
    line
      .gsub('one', '1')
      .gsub('two', '2')
      .gsub('three', '3')
      .gsub('four', '4')
      .gsub('five', '5')
      .gsub('six', '6')
      .gsub('seven', '7')
      .gsub('eight', '8')
      .gsub('nine', '9')
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('./input/day1')
  puts Day1.new.part1(input)
end
