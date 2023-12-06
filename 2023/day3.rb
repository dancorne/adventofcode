# frozen_string_literal: true

class Day3
  def initialize(input)
    @lines = input.lines
    @symbol_coordinates = find_symbols
    @possible_gears = find_possible_gears
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
        # Oh maybe I could just test if that coordinate is a symbol here rather than finding all symbols first.
        # Initial testing suggests that fails on the boundaries due to -1/+1 going off the edge of the index but maybe there's a simple way to avoid...
        return true if @symbol_coordinates.include?([row, col])
      end
    end
    false
  end

  def part1
    find_part_numbers.sum
  end

  def find_possible_gears
    gear_coordinates = []
    @lines.each_with_index do |line, row|
      line.chomp.chars.each_with_index do |e, col|
        gear_coordinates << [row, col] if e == '*'
      end
    end
    gear_coordinates
  end

  def find_gear_numbers
    gears = Hash[@possible_gears.product([[]])]
    @lines.each_with_index do |line, row|
      counter = 0
      while line.match?(/\d+/)
        before, digits, line = line.partition(/\d+/)
        first_index = counter + before.size
        last_index = counter + before.size + digits.size - 1
        gear = nextdoor_gear(row, first_index, last_index)
        gears[gear] += [digits.to_i] if gear
        counter = last_index + 1
      end
    end
    gears
  end

  def nextdoor_gear(line, start_index, end_index)
    # I swear to god if this challenge includes digits next to multiple gears I'm gonna cry...
    (line - 1..line + 1).each do |row|
      (start_index - 1..end_index + 1).each do |col|
        return [row, col] if @possible_gears.include?([row, col])
      end
    end
    nil
  end

  def part2
    gears = find_gear_numbers
    gears.map { |_, numbers| numbers.inject(:*) if numbers.size == 2 }.compact.sum
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('./input/day3')
  puts Day3.new(input).part1
  puts Day3.new(input).part2
end
