# frozen_string_literal: true

class Day3
  def initialize(input)
    @input = input
    @lines = input.lines
    @chars = [*input.lines.map { |line| line.chomp.chars }]
    @symbol_coordinates = find_symbols
  end

  def find_symbols
    symbol_coordinates = []
    @lines.each_with_index do |line, row|
      line.chomp.chars.each_with_index do |e, col|
        symbol_coordinates << [row, col] unless e =~ /[\d.]/
      end
    end
    symbol_coordinates
  end

  def find_part_numbers
    numbers = []
    @lines.each_with_index do |line, row|
      counter = 0
      while line.match?(/\d+/)
        before, digits, line = line.partition(/\d+/)
        first_index = counter + before.size
        last_index = counter + before.size + digits.size - 1
        numbers << digits.to_i if next_to_symbol?(row, first_index, last_index)
        counter = last_index + 1
      end
    end
    numbers
  end

  def next_to_symbol?(line, start_index, end_index)
    (line - 1..line + 1).each do |row|
      (start_index - 1..end_index + 1).each do |col|
        return true if @symbol_coordinates.include?([row, col])
      end
    end
    false
  end

  def part1
    find_part_numbers.sum
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('./input/day3')
  puts Day3.new(input).part1
  # puts Day3.new(input).part2
end
