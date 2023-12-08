# frozen_string_literal: true

class Day4
  def part1(input)
    input.lines.sum do |line|
      winning_numbers = parse_numbers(line.split(':')[1].split('|')[0])
      scratched_numbers = parse_numbers(line.split('|')[1])
      count = (winning_numbers & scratched_numbers).size
      count.zero? ? 0 : 2**(count - 1)
    end
  end

  def parse_numbers(line)
    line.split.map(&:to_i)
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('./input/day4')
  puts Day4.new.part1(input)
  # puts Day4.new.part2(input)
end
