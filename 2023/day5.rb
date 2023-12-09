# frozen_string_literal: true

class Day5
  def initialize(input)
    @seeds, @mappings = parse_sections(input)
  end

  def parse_sections(input)
    sections = input.split(/\n\n/)
    seeds = ''
    mappings = {}
    sections.each do |section|
      case section
      when /^seeds:/
        seeds = section.split(': ')[1].split.map(&:to_i)
      else
        mappings[section.split[0]] = section.lines[1..].map(&:chomp)
      end
    end
    [seeds, mappings]
  end

  def find_mapped_number(mapping, source)
    @mappings[mapping].each do |line|
      destination_start, source_start, len = line.split.map(&:to_i)
      return (destination_start - source_start + source) if (source_start..source_start + len).include?(source)
    end
    source
  end

  def seed_to_location(seed)
    soil = find_mapped_number('seed-to-soil', seed)
    fertilizer = find_mapped_number('soil-to-fertilizer', soil)
    water = find_mapped_number('fertilizer-to-water', fertilizer)
    light = find_mapped_number('water-to-light', water)
    temperature = find_mapped_number('light-to-temperature', light)
    humidity = find_mapped_number('temperature-to-humidity', temperature)
    find_mapped_number('humidity-to-location', humidity)
  end

  def part1
    lowest = nil
    @seeds.each do |seed|
      location = seed_to_location(seed)
      lowest = location if lowest.nil? || seed_to_location(seed) < lowest
    end
    lowest
  end
end

if __FILE__ == $PROGRAM_NAME
  input = File.read('./input/day5')
  puts Day5.new(input).part1
  # puts Day5.new(input).part2
end
