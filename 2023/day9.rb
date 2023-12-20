# frozen_string_literal: true

class Day9
  def initialize(input)
    @histories = input.lines.map { |line| line.split.map(&:to_i) }
  end

  def calculate_next(arr)
    return arr[0] if arr.uniq.length == 1

    new_array = (1...arr.length).map { |n| arr[n] - arr[n - 1] }
    arr[-1] + calculate_next(new_array)
  end

  def part1
    @histories.sum { |h| calculate_next(h) }
  end

  def calculate_previous(arr)
    return arr[0] if arr.uniq.length == 1

    new_array = (1...arr.length).map { |n| arr[n] - arr[n - 1] }
    arr[0] - calculate_previous(new_array)
  end

  def part2
    @histories.sum { |h| calculate_previous(h) }
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('./input/day9')
  puts Day9.new(input).part1
  puts Day9.new(input).part2
end
