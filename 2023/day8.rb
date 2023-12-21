# frozen_string_literal: true

class Day8
  def initialize(input)
    @steps = input.lines[0].chomp.chars
    @nodes = Hash[input.lines[2..].map { |line| [line.split(' = ')[0], line.split(' = ')[1].scan(/\w+/)] }]
  end

  def follow_step(node, l_or_r)
    case l_or_r.downcase
    when 'l' then @nodes[node][0]
    when 'r' then @nodes[node][1]
    else raise 'Bug: Only L or R can be used'
    end
  end

  def part1
    node = 'AAA'
    count = 0
    until node == 'ZZZ'
      node = follow_step(node, @steps[count % @steps.length])
      count += 1
    end
    count
  end

  def part2
    starting_nodes = @nodes.keys.select { |node| node.end_with? 'A' }
    starting_nodes.map do |node|
      count = 0
      until node.end_with? 'Z'
        node = follow_step(node, @steps[count % @steps.length])
        count += 1
      end
      count
    end.reduce(1, :lcm)
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('./input/day8')
  puts Day8.new(input).part1
  puts Day8.new(input).part2
end
