# frozen_string_literal: true

class Day9
  def initialize(input)
    @histories = input.lines.map { |line| line.split.map(&:to_i) }
  end

  def recurse(arr)
    return arr[0] if arr.uniq.length == 1

    new_array = (1...arr.length).map { |n| arr[n] - arr[n - 1] }
    arr[-1] + recurse(new_array)
  end

  def part1
    @histories.sum { |h| recurse(h) }
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('./input/day9')
  puts Day9.new(input).part1
  # puts Day9.new(input).part2
end
