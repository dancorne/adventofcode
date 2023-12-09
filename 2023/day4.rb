# frozen_string_literal: true

class Day4
  def part1(input)
    input.lines.sum do |line|
      count = process_game(line)
      count.zero? ? 0 : 2**(count - 1)
    end
  end

  def process_game(line)
    winning_numbers = parse_numbers(line.split(':')[1].split('|')[0])
    scratched_numbers = parse_numbers(line.split('|')[1])
    (winning_numbers & scratched_numbers).size
  end

  def parse_numbers(line)
    line.split.map(&:to_i)
  end

  def part2(input)
    card_scores = input.lines.map { |line| process_game(line) }
    process_games(card_scores, 0, card_scores.size)
  end

  def process_games(card_scores, start_index, no_to_play, count = 0)
    card_scores[start_index, no_to_play].each_with_index do |score, idx|
      count += 1
      count = process_games(card_scores, start_index + idx + 1, score, count)
    end
    count
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('./input/day4')
  puts Day4.new.part1(input)
  puts Day4.new.part2(input)
end
