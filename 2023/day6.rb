# frozen_string_literal: true

class Day6
  def initialize(input)
    @input = input
    @races = input.lines[0].split[1..].map(&:to_i).zip(input.lines[1].split[1..].map(&:to_i)).to_h
  end

  def part1
    @races.map do |time, record|
      low_speed, high_speed = find_speed_for_target_time(time, record + 1)
      high_speed - low_speed + 1
    end.inject(:*)
  end

  def find_speed_for_target_time(time, distance)
    # Simultaneous equations gives us quadratic for speed v**2 - t*v + d = 0
    low_speed = (time - Math.sqrt(time**2 - 4 * distance)) / 2
    high_speed = (time + Math.sqrt(time**2 - 4 * distance)) / 2
    [low_speed.ceil, high_speed.floor]
  end

  def part2
    time = @input.lines[0].delete(' ').split(':')[1].to_i
    record = @input.lines[1].delete(' ').split(':')[1].to_i
    low_speed, high_speed = find_speed_for_target_time(time, record + 1)
    high_speed - low_speed + 1
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('./input/day6')
  puts Day6.new(input).part1
  puts Day6.new(input).part2
end
