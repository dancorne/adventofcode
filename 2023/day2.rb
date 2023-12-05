# frozen_string_literal: true

class Day2
  def parse_games(input)
    input.lines.to_h { |line| [line.scan(/Game (\d+):/)[0][0], parse_results(line.split(': ')[1])] }
  end

  def parse_results(results)
    results.split('; ').map { |game| parse_result(game) }
  end

  def parse_result(result)
    result.split(', ').to_h { |colour| colour.split(' ').reverse }.transform_values(&:to_i)
  end

  def part1(input)
    games = parse_games(input)
    games.delete_if { |_, results| results.any? { |result| !possible_result?(result) } }
    games.keys.map(&:to_i).sum
  end

  def possible_result?(result)
    result.fetch('green', 0) <= 13 && result.fetch('red', 0) <= 12 && result.fetch('blue', 0) <= 14
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('./input/day2')
  puts Day2.new.part1(input)
  # puts Day2.new.part2(input)
end
